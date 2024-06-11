# Ollama Pipeline for Lilypad and Docker 🐋
Based on Ollama, the Ollama Pipeline modules for Lilypad allow you generate text on Lilypad using various models.

# Usage
These modules are designed to be run in a Docker container, either through the Lilypad Network or in Docker directly.

## Options and tunables
The following tunables are available. All of them are optional, and have default settings that will be used if you do not provide them.

| Name | Description | Default | Available options |
|------|-------------|---------|-------------------|
| `Prompt` | A text prompt for the model | "Hello AI world" | Any string |

See the usage sections for the runner of your choice for more information on how to set and use these variables.

## Lilypad
To run Ollama Pipeline in Lilypad, you can use the following commands:

### LLaMa3
```bash
lilypad run ollama-pipeline:llama3-8b-lilypad1 -i Prompt='Hello AI World'
```

### Specifying tunables

If you wish to specify more than one tunable, such as the number of steps, simply add more `-i` flags, like so:

```bash
lilypad run ollama-pipeline -i Prompt="an astronaut floating against a white background" -i Steps=69
```

See the options and tunables section for more information on what tunables are available.

## Docker

To run these modules in Docker, you can use the following commands:

### LLaMa3

```bash
docker run -ti --gpus all \
    -v $PWD/outputs:/outputs \
    -e PROMPT="Hello AI World" \
    ollama:llama3-8b-lilypad4
```

### Specifying tunables
If you wish to specify more than one tunable, such as the number of steps, simply add more `-e` flags, like so:

```bash
-e PROMPT="Hello AI World" \
-e STEPS=69 \
-e SIZE=2048 \
```

See the options and tunables section for more information on what tunables are available.

# Development
You can build the Docker containers that form this module by following these steps (replacing Dockerfile-llama3-8b and its Git tags with the appropriate Dockerfile and tags for the model you wish to use):

```
# From the root directory of this repository, change to the docker folder.
cd docker
# Build the docker image
DOCKER_BUILDKIT=1 docker build -f Dockerfile-llama3-8b -t ollama:llama3-8b-lilypad4 --target runner .
```
```
mkdir -p outputs
```

# Publishing for production
To publish all of the images, run `scripts/build.sh`. Once you're satisfied, run `release.sh`.

# Testing
Fork this repository and make your changes. Then, build a Docker container and run the module with your changes locally to test them out.

Once you've made your changes, publish your Docker image, then edit `lilypad_module.json.tmpl` to point at it and create a Git tag such as `v0.9-lilypad10`.

You can then run your module with 

`lilypad run github.com/git_username/example:v0.1.2 -i Prompt="Hello AI World"` to test your changes, replacing `git_username` with your username and `v0.1.2` with the tag you created.

Note that most nodes on the public Lilypad network will be unlikely to run your module (due to allowlisting), so you may need to run a Lilypad node to test your changes. Once your module is stable and tested, you can request that it be adopted as an official module. Alternatively, if you're simply making changes to this module instead of making a new one, feel free to submit a pull request.

