# Hubot

1. set up env in `hubot.env`
2. `docker-compose -H $DOCKERHOST up -d`
3. ???
4. PROFIT

## FQA

### Q: How to add scripts?
A: Create a PR and ping @mlen for redeploy.

### Q: Can I ping @mlen so he adds the script for me?
A: No.

### Q: Can I redeploy myself?
A: Maybe someday. Currently docker socket binds to lo, but I may add TLS and 
expose it some day.
