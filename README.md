# ReproFed Community Profiles

![License](https://img.shields.io/github/license/ephmo/reprofed-profiles)

Community-maintained profiles for [ReproFed](https://github.com/ephmo/reprofed) — the declarative Fedora configuration manager.

This repository hosts **community-contributed profiles** that extend **ReproFed** beyond the officially supported profiles.

---

## 🚀 Purpose of This Repository

The **ReproFed repository** maintains a small, stable set of officially supported profiles (such as _gnome_, _kde_, _cosmic_, and _server_).

This repository exists to:

- Allow the community to create and share new profiles
- Encourage experimentation without affecting core stability
- Provide a central place for reusable, declarative Fedora setups

Profiles in this repository are **not officially supported** but are available for anyone to use, adapt, or improve.

---

## 📦 Profile Requirements

A `example-gnome.yaml` file is provided in the `profiles/templates/` directory and serves as the authoritative reference for all profile authors.

Each new profile must be created as a YAML file and placed in the `profiles/` directory, following the structure and conventions defined in the template.

---

## 📥 Using a Community Profile

To use a community profile from this repository:

1. Clone or download this repository
2. Copy the desired profile file(s) from the `profiles/` directory into `/opt/reprofed/profiles/`.

---

## 🤝 Contributing

Contributions are welcome and appreciated!

### Adding a New Profile

1. Fork this repository
2. Copy `profiles/templates/example-gnome.yaml` and adapt it to your use case.
3. Submit a Pull Request for review.

### Important Notes

- Only community profiles belong in this repository
- Official profiles remain in the [ReproFed](https://github.com/ephmo/reprofed) repository
- Profiles should remain declarative and reproducible
- Avoid destructive or unsafe defaults

If you are unsure whether a profile belongs here, open an issue to discuss it first

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

**ReproFed — Your Fedora, reproducible by design.**
