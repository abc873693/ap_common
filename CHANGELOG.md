# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2024-10-11

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common` - `v0.26.0-dev.1`](#ap_common---v0260-dev1)
 - [`ap_common_announcement_ui` - `v0.0.2`](#ap_common_announcement_ui---v002)
 - [`ap_common_core` - `v0.0.3`](#ap_common_core---v003)
 - [`ap_common_flutter_core` - `v0.0.2`](#ap_common_flutter_core---v002)
 - [`ap_common_flutter_platform` - `v0.0.2`](#ap_common_flutter_platform---v002)
 - [`ap_common_flutter_ui` - `v0.0.2`](#ap_common_flutter_ui---v002)
 - [`ap_common_firebase` - `v0.17.0-dev.1`](#ap_common_firebase---v0170-dev1)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `ap_common_firebase` - `v0.17.0-dev.1`

---

#### `ap_common` - `v0.26.0-dev.1`

 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))
 - **FEAT**: `AppStoreUtil` and `PlatformUtil` for `ap_common_flutter_core`. ([d87dc711](https://github.com/abc873693/ap_common/commit/d87dc7117a040b31b42abd2d1122a891fd04988e))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([e91e9b4c](https://github.com/abc873693/ap_common/commit/e91e9b4cdf3cb7d4e2dde1dd8ec5f66556d38461))
 - **FEAT**: centralized package lint rule. ([08db9e1f](https://github.com/abc873693/ap_common/commit/08db9e1f00118f11ef389b194585626d7c51c3ab))
 - **FEAT**: migrate `NotificationUtil` and `Preference` to injection version. ([ac50e177](https://github.com/abc873693/ap_common/commit/ac50e177cb276937b2411397959a845f98fa297a))
 - **FEAT**: `ap_common` import `ap_common_core`. ([a6aa801f](https://github.com/abc873693/ap_common/commit/a6aa801f2165281be61afbe33f4072827e5979bc))
 - **FEAT**: migrate `model`  `util` `config` to new `ap_common_core`. ([90f16bc9](https://github.com/abc873693/ap_common/commit/90f16bc9e38eb10f2d8f3b633f4c46a0a9e2ff95))
 - **FEAT**: update example path. ([4d7390c9](https://github.com/abc873693/ap_common/commit/4d7390c9212631e1233c37c901a4454610783926))
 - **FEAT**: move main package to directory `packages` for melos prepare. ([8af51340](https://github.com/abc873693/ap_common/commit/8af51340576e8236b261a21188cc8feaa0776785))

#### `ap_common_announcement_ui` - `v0.0.2`

 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))

#### `ap_common_core` - `v0.0.3`

 - **FIX**: `ap_common_core` separate static error. ([629ba29d](https://github.com/abc873693/ap_common/commit/629ba29d7d0aa59270eec1da45e49daebe3bf8b5))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([e91e9b4c](https://github.com/abc873693/ap_common/commit/e91e9b4cdf3cb7d4e2dde1dd8ec5f66556d38461))
 - **FEAT**: centralized package lint rule. ([08db9e1f](https://github.com/abc873693/ap_common/commit/08db9e1f00118f11ef389b194585626d7c51c3ab))
 - **FEAT**: release `ap_common_core` v0.0.2. ([630bcec0](https://github.com/abc873693/ap_common/commit/630bcec0b9158ddd91c5fab9de1f630447547490))
 - **FEAT**: migrate `NotificationUtil` and `Preference` to injection version. ([ac50e177](https://github.com/abc873693/ap_common/commit/ac50e177cb276937b2411397959a845f98fa297a))
 - **FEAT**: `ap_common` import `ap_common_core`. ([a6aa801f](https://github.com/abc873693/ap_common/commit/a6aa801f2165281be61afbe33f4072827e5979bc))
 - **FEAT**: migrate `model`  `util` `config` to new `ap_common_core`. ([90f16bc9](https://github.com/abc873693/ap_common/commit/90f16bc9e38eb10f2d8f3b633f4c46a0a9e2ff95))

#### `ap_common_flutter_core` - `v0.0.2`

 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))
 - **FEAT**: `AppStoreUtil` and `PlatformUtil` for `ap_common_flutter_core`. ([d87dc711](https://github.com/abc873693/ap_common/commit/d87dc7117a040b31b42abd2d1122a891fd04988e))
 - **FEAT**: migrate `util` `l10n`  to new `ap_common_flutter_core`. ([e91e9b4c](https://github.com/abc873693/ap_common/commit/e91e9b4cdf3cb7d4e2dde1dd8ec5f66556d38461))

#### `ap_common_flutter_platform` - `v0.0.2`

 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))

#### `ap_common_flutter_ui` - `v0.0.2`

 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))


## 2024-10-11

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common_plugin` - `v0.5.0-dev.0`](#ap_common_plugin---v050-dev0)

---

#### `ap_common_plugin` - `v0.5.0-dev.0`

 - **FEAT**: centralized package lint rule. ([08db9e1f](https://github.com/abc873693/ap_common/commit/08db9e1f00118f11ef389b194585626d7c51c3ab))
 - **FEAT**: update example path. ([4d7390c9](https://github.com/abc873693/ap_common/commit/4d7390c9212631e1233c37c901a4454610783926))
 - **FEAT**: CI setting for mono-repo. ([d22f6d15](https://github.com/abc873693/ap_common/commit/d22f6d15f64879dbf9711574aba4bba6e227f128))
 - **FEAT**: melos generation setup. ([90497edd](https://github.com/abc873693/ap_common/commit/90497edd12d449e66991d654a03175edebf1e816))
 - **FEAT**: melos basic setting. ([fa8e1946](https://github.com/abc873693/ap_common/commit/fa8e1946fd478c1a0cf1635eaeb0fb60cc264750))


## 2024-10-11

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common_firebase` - `v0.17.0-dev.0`](#ap_common_firebase---v0170-dev0)

---

#### `ap_common_firebase` - `v0.17.0-dev.0`

 - **FIX**: `ap_common_firebase` dependency usage. ([d5098b42](https://github.com/abc873693/ap_common/commit/d5098b426c00de39c0736a8ca535a76be0722331))
 - **FIX**: `ap_common_firebase` separate static error. ([1c8da8ea](https://github.com/abc873693/ap_common/commit/1c8da8ea57c7e3e48d3e53a824e76968d56a97b5))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))
 - **FEAT**: improve `ap_common_firebase` package import usage. ([aa6462c4](https://github.com/abc873693/ap_common/commit/aa6462c407b074b6fa95969765e28c85dc187de5))
 - **FEAT**: centralized package lint rule. ([08db9e1f](https://github.com/abc873693/ap_common/commit/08db9e1f00118f11ef389b194585626d7c51c3ab))
 - **FEAT**: update example path. ([4d7390c9](https://github.com/abc873693/ap_common/commit/4d7390c9212631e1233c37c901a4454610783926))
 - **FEAT**: melos generation setup. ([90497edd](https://github.com/abc873693/ap_common/commit/90497edd12d449e66991d654a03175edebf1e816))
 - **FEAT**: melos basic setting. ([f2d4fafd](https://github.com/abc873693/ap_common/commit/f2d4fafd48c812901f5394fb83f6f5e5ff67401c))


## 2024-10-11

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`ap_common_firebase` - `v0.17.0-dev.0`](#ap_common_firebase---v0170-dev0)

---

#### `ap_common_firebase` - `v0.17.0-dev.0`

 - test

 - **FIX**: `ap_common_firebase` dependency usage. ([d5098b42](https://github.com/abc873693/ap_common/commit/d5098b426c00de39c0736a8ca535a76be0722331))
 - **FIX**: `ap_common_firebase` separate static error. ([1c8da8ea](https://github.com/abc873693/ap_common/commit/1c8da8ea57c7e3e48d3e53a824e76968d56a97b5))
 - **FEAT**: move UI implement to `ap_common_flutter_ui`. ([304b60fa](https://github.com/abc873693/ap_common/commit/304b60fa245dbd0b1d4d3ae649b5468e9ee46f71))
 - **FEAT**: move native platform util implement to `ap_common_flutter_platform`. ([8cb047f1](https://github.com/abc873693/ap_common/commit/8cb047f167d6f10eaab063449a88646092faff10))
 - **FEAT**: improve `ap_common_firebase` package import usage. ([aa6462c4](https://github.com/abc873693/ap_common/commit/aa6462c407b074b6fa95969765e28c85dc187de5))
 - **FEAT**: centralized package lint rule. ([08db9e1f](https://github.com/abc873693/ap_common/commit/08db9e1f00118f11ef389b194585626d7c51c3ab))
 - **FEAT**: update example path. ([4d7390c9](https://github.com/abc873693/ap_common/commit/4d7390c9212631e1233c37c901a4454610783926))
 - **FEAT**: melos generation setup. ([90497edd](https://github.com/abc873693/ap_common/commit/90497edd12d449e66991d654a03175edebf1e816))
 - **FEAT**: melos basic setting. ([f2d4fafd](https://github.com/abc873693/ap_common/commit/f2d4fafd48c812901f5394fb83f6f5e5ff67401c))

