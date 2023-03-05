# auto-vpn

Auto setup VPN server and VPN bridge.
Right now we are running it with docker compose, but eventually we will run it with kubernetes.
In that case, the goal is to set up a Compute Engine in ansible, make it a kubernetes node, set up a VPN server there, and set up a VPN Bridge to the house.

## command

```bash
# init
make init

# init terraform state
make terraform-init

# create terraform state bucket & terraform init
make terraform-create-state-bucket

# create compute engine
make terraform-create-vm

# setup compute engine ssh & host ip
make setup-ssh

# install and run docker compose for compute engine
make install

# run local vpn bridge
make bridge
```
