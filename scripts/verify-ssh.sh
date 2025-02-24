while read IP FQDN HOST SUBNET; do 
  ssh -n vagrant@${IP} uname -o -m
done < machines.txt

while read IP FQDN HOST SUBNET; do
    CMD="sed -i 's/^127.0.1.1.*/127.0.1.1\t${FQDN} ${HOST}/' /etc/hosts"
    ssh -n vagrant@${IP} "$CMD"
    ssh -n vagrant@${IP} hostnamectl hostname ${HOST}
done < machines.txt
