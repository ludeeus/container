class Version:
    def __init__(self, version: str):
        self._version = str(version)

    def __repr__(self):
        return f"<Version {self._version}>"

    @property
    def string(self):
        return str(self._version)

    @property
    def major(self):
        return int(self._version.split(".")[0].split(".")[0].split("-")[0])

    @property
    def minor(self):
        if len(self._version.split(".")) >= 2:
            return int(self._version.split(".")[1].split(".")[0].split("-")[0])

    @property
    def patch(self):
        if len(self._version.split(".")) >= 3:
            return int(self._version.split(".")[2].split(".")[0].split("-")[0])

    @property
    def tags(self):
        tags = ["latest"]
        if self.major:
            tags.append(f"{self.major}")
        if self.minor:
            tags.append(f"{self.major}.{self.minor}")
        if self.patch != None:
            tags.append(f"{self.major}.{self.minor}.{self.patch}")
        return tags

    @property
    def modifier(self):
        if "-" in self._version.split(".")[-1]:
            return self._version.split(".")[-1].split("-")[-1]

    def equals(self, compareto: "Version"):
        if compareto.major != self.major:
            return False
        elif compareto.minor != self.minor:
            return False
        elif compareto.patch != self.patch:
            return False
        elif compareto.modifier != self.modifier:
            return False
        return True