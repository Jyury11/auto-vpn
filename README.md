# auto-vpn

Auto setup VPN server and VPN bridge.
Right now we are running it with docker compose, but eventually we will run it with kubernetes.
In that case, the goal is to set up a Compute Engine in ansible, make it a kubernetes node, set up a VPN server there, and set up a VPN Bridge to the house.
