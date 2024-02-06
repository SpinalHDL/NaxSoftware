#!/usr/bin/env python3
import re
import subprocess
import os
import pathlib
import sys

PREFIX = 'riscv64-unknown-elf-'
GCC = PREFIX + 'gcc'
OBJDUMP = PREFIX + 'objdump'

BASE_GCC_OPTS = [
    '-static',
    '-mcmodel=medany',
    '-g',
    '-fvisibility=hidden',
    '-nostdlib',
    '-nostartfiles',
    '-Wl,--no-warn-rwx-segments',
    '-I.'
]

RED = '\x1b[1;31m'
GREEN = '\x1b[1;32m'
CLEAR = '\x1b[0m'


def make_march(isa:str) -> str:
    xlen = isa[2:4]
    march = 'rv' + xlen
    if "I" in isa:
        march += 'i'
    if "M" in isa:
        march += 'm'
    if "A" in isa:
        march += 'a'
    if "F" in isa:
        march += 'f'
    if "D" in isa:
        march += 'd'
    if "C" in isa:
        march += 'c'
    if "Zicsr" in isa:
        march += '_zicsr'
    if "Zifencei" in isa:
        march += '_zifencei'
    if "Zca" in isa:
        march += '_zca' 
    if "Zcb" in isa:
        march += '_zcb'  
    if "Zba" in isa:
        march += '_zba'
    if "Zbb" in isa:
        march += '_zbb'
    if "Zbc" in isa:
        march += '_zbc'    
    if "Zbs" in isa:
        march += '_zbs'
    return march, xlen


def build_info(file, arch, hw_misaligned):
    build_isa = None
    defs = []
    with open(file, 'r') as f:
        for line in f:
            if 'RVTEST_ISA' in line:
                build_isa = line.split('"')[1]

            if 'RVTEST_CASE' in line:
                # parsing e.g. RVTEST_CASE(0,"//check ISA:=regex(.*32.*);check ISA:=regex(.*I.*A.*);def TEST_CASE_1=True;",amoadd.w)
                _, things, _ = line.split(',')
                
                things = things[len('"//'):-1] # remove "// and trailing
                for c in things.split(';'):
                    c = c.strip()
                    if c.startswith('check ISA:=regex('):                 
                        regex = c[len('check ISA:=regex('):-1]
                        if re.match(regex, arch) is None:
                            print(f'{RED}SKIP{CLEAR}  {file} :: {c}')
                            return False, None, None
                    
                    elif c.startswith('def '):
                        defs.append(c[len('def '):])
                    
                    elif c == 'check hw_data_misaligned_support:=True':
                        if not hw_misaligned:
                            print(f'{RED}SKIP{CLEAR}  {file} :: {c}')
                            return False, None, None
                    
                    elif c == '':
                        pass
                    
                    else:
                        raise Exception(f"don't understand string: {c} in {file}")
                
                print(f'{GREEN}BUILD{CLEAR} {file}')
                return True, build_isa, defs


def build(inp, outp, suite, isa, defs):
    march, xlen = make_march(isa)
    mabi = 'ilp32' if xlen == '32' else 'lp64'
    if 'D' in isa:
        mabi += 'd'
    elif 'F' in isa:
        mabi += 'f'
    flen = '64' if 'D' in isa else '32'
    
    subprocess.run([
            GCC,
            *BASE_GCC_OPTS,
            f'-I{suite}/env',
            f'-march={march}',
            f'-mabi={mabi}',
            f'-DXLEN={xlen}',
            f'-DFLEN={flen}',
            *['-D' + s for s in defs],
            '-Tlinkmono.ld',
            inp, 
            '-o',
            outp
        ], check=True)
    with open(f'{outp}.dis.S', 'w') as f:
        subprocess.run([OBJDUMP, '--source', outp], stdout=f, check=True)


def build_folder(suite, folder, out, isa, hw_misaligned):
    isa = isa.replace('G', 'IMAFDZicsrZifencei')
    for file in os.listdir(os.path.join(suite, folder, 'src')):
        do, build_isa, defs = build_info(os.path.join(suite, folder, 'src', file), isa, hw_misaligned)
        if do:
            pathlib.Path(os.path.join(out, folder)).mkdir(parents=True, exist_ok=True)
            build(
                os.path.join(suite, folder, 'src', file),
                os.path.join(out, folder, file[:-2] + '.elf'),
                suite,
                build_isa,
                defs
            )


def main():
    suite = sys.argv[1]

    for xlen in ['32', '64']:
        group, isa = f'rv{xlen}i_m', f'RV{xlen}IMCZicsrZifenceiZbaZbbZbcZbs'
        for ext in os.listdir(os.path.join(suite, group)):
            if ext.startswith('.'):
                continue

            print(f'>>> {group} - {ext} - {isa}')
            build_folder(suite, os.path.join(group, ext), '.', isa, hw_misaligned=True)


if __name__ == '__main__':
    main()
