## 0.6.0
### Added
* `reverse` parameter to `OverflowView` and `OverflowView.flexible` constructors.
  * When `reverse` is `true`, overflow occurs from the start (left for horizontal, top for vertical) instead of the end.
  * Enables right-to-left and bottom-to-top overflow behavior.

### Changed
* Optimized reverse layout performance to match normal mode efficiency (O(k) for fixed, O(n) for flexible).

## 0.5.0
### Changed
* Update Flutter constraints.
* Update version of value_layout_builder.

### Fixed
* Flutter 3.32 breaking changes issue.

## 0.4.0
### Changed
* Update Flutter and Dart SDK constraints.
* Update dependencies.

## 0.3.1
### Changed
* Small formatting issues.

## 0.3.0
### Changed
* Add support for null-safety.
* Increase the minimum version of Flutter.
* Increase the minimum version of dart sdk.

## 0.2.2
### Fixed
* [Issue when rendering overflow indicator after having displayed it once.](https://github.com/letsar/overflow_view/issues/3)

## 0.2.1
### Changed
* The parameter `spacing` can be negative to achieve a stacked effect.

## 0.2.0
### Added
* An `OverflowView.flexible` constructor to let children determine their own size.

## 0.1.0
* Initial Open Source release.
