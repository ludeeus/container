import requests


def get_docker_tags(image):
    skip = ["3.9", "3.9.6", "edge", "latest"]
    try:
        if image != "debian":
            url = (
                f"https://registry.hub.docker.com/v2/repositories/library/{image}/tags"
            )
            response = requests.get(url).json()
            return sorted(
                [
                    x["name"]
                    for x in response["results"]
                    if x["name"][0].isdigit()
                    and x["name"] not in skip
                    and "." in x["name"]
                ]
            ).pop()

        url = f"https://registry.hub.docker.com/v1/repositories/library/debian/tags"
        response = requests.get(url).json()
        tags = [
            x["name"]
            for x in response
            if x["name"][0].isdigit()
            and x["name"] not in skip
            and "." in x["name"]
            and "-slim" in x["name"]
            and int(x["name"].split(".")[0]) >= 10
        ]
        return tags.pop()
    except Exception as e:
        print(f"Could not get version for {image} - {e}")
        return []
