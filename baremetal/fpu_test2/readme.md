

http://www.jhauser.us/arithmetic/TestFloat.html

```bash
cd vector
kinds=(f ui i)
for kind in ${kinds[@]}; do
  testfloat_gen -n 400000 ${kind}32  | xxd -r -p | xxd -g 4 -e | xxd -r > ${kind}32.bin
  testfloat_gen -n 400000 ${kind}64  | xxd -r -p | xxd -g 8 -e | xxd -r > ${kind}64.bin
done
```