# test_that("get_basedata returns expected results", {
#   res <- get_basedata()
#   expect_s3_class(res, "data.frame")
#   expect_equal(2 * 2, 4)
# })

test_that("get_basedata fails appropriately", {
  expect_error(get_basedata("aoi"), "'aoi' is not an sf or sfc object")
})
