# Dockerfile
FROM rust:latest as builder
WORKDIR /home
RUN apt update && apt install musl-tools -y
RUN rustup target add x86_64-unknown-linux-musl
RUN cargo install --git https://github.com/indygreg/PyOxidizer.git --branch stable pyoxidizer

COPY ./app/* /home/
RUN pyoxidizer build --target-triple x86_64-unknown-linux-musl
RUN ldd /home/build/x86_64-unknown-linux-musl/debug/exe/quickemu_watcher
RUN ls -lahk /home/build/x86_64-unknown-linux-musl/debug/exe/quickemu_watcher 
# copy then compile 
#RUN cargo build --release 
#RUN cargo install --target x86_64-unknown-linux-musl --path .
FROM scratch
COPY --from=builder /home/build/x86_64-unknown-linux-musl/debug/exe/quickemu_watcher /quickemu_watcher

CMD [ "/quickemu_watcher" ] 
