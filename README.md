# meta-swift examples

This repo provides a simple workspace to compile the [meta-swift](https://github.com/jeremy-prater/meta-swift) layer
for a sizeable set of supported Yocto machines for the purpose of evalulation and testing.

The following machines are supported and have been tested:

- `qemuarm`
- `qemuarm64`
- `qemux86-64`
- `beaglebone-yocto`
- `raspberrypi-armv7`
- `raspberrypi-armv8`

Others will likely also work, but have not been tested.

## Clone

```console
git clone https://github.com/swift-embedded-linux/meta-swift-examples.git --recurse-submodules
```

## Build

It is recommended to build and run the included container for a working environment for
building Yocto:

```console
./build-container.sh
./run-container.sh
```

The scripts support either [Docker](https://docs.docker.com/desktop/setup/install/linux/) or [Podman](https://podman.io/docs/installation), so make sure either one is installed.

Build the `core-image-minimal` for the default architecture (`qemuarm`):

```console
./build.sh
```

You may also customize the ./build.sh invocation by adding `MACHINE=` and/or `EXTRA_IMAGE_INSTALL=`:

```console
MACHINE=beaglebone-yocto EXTRA_IMAGE_INSTALL="openssh" ./build.sh
```

Builds will be found under poky/build-$MACHINE. Downloads and sstate-cache are shared between builds to keep disk size down as much as possible.

## Execution

Execute `hello-world` for the default `qemuarm` machine. This is an easy way to confirm that the meta-swift build worked correctly:

```console
./execute.exp
```

If you built for a different machine, prefix the command with `MACHINE=` like this:

```console
MACHINE=beaglebone-yocto ./build.sh
```

## Github Actions

Start runner and trigger job via Github API:

<https://github.com/xavgru12/github-self-hosted-runner>
