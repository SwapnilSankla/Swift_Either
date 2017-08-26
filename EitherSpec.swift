import XCTest

class EitherSpec: XCTestCase {
    public func testIsLeft_returnTrue_whenEitherHasLeftValue() {
        let either: Either<String, Int> = Either.left("Hello")
        XCTAssertTrue(either.isLeft())
        XCTAssertFalse(either.isRight())
    }

    public func testIsRight_returnTrue_whenEitherHasRightValue() {
        let either: Either<String, Int> = Either.right(10)
        XCTAssertTrue(either.isRight())
        XCTAssertFalse(either.isLeft())
    }

    public func testLeftValue_returnLeft_whenEitherIsLeft() {
        let either: Either<String, Int> = Either.left("Hello")
        XCTAssertEqual("Hello", either.leftValue())
        XCTAssertNil(either.rightValue())
    }

    public func testRightValue_returnRight_whenEitherIsRight() {
        let either: Either<String, Int> = Either.right(10)
        XCTAssertEqual(10, either.rightValue())
        XCTAssertNil(either.leftValue())
    }

    public func testEither_returnsLeft_whenEitherIsLeft() {
        let left = { (int: Int) in return String(describing: int) }
        let right = { (double: Double) in return String(describing: double) }

        let either: Either<Int, Double> = Either.left(10)
        let result = either.either(left: left, right: right)
        XCTAssertEqual("10", result)
    }

    public func testEither_returnsRight_whenEitherIsRight() {
        let left = { (int: Int) in return String(describing: int) }
        let right = { (double: Double) in return String(describing: double) }

        let either: Either<Int, Double> = Either.right(10.25)
        let result = either.either(left: left, right: right)
        XCTAssertEqual("10.25", result)
    }

    public func testBind_executesLeftFunction_whenEitherIsLeft() {
        let either: Either<String, Int> = Either.left("Hello")
        var result = ""
        let left = { (string: String) in result = "\(string), Welcome to the Functional World" }
        let right = { (int: Int) in result = "Number \(int), Welcome to the Functional World" }
        either.bind(left: left, right: right)
        XCTAssertEqual("Hello, Welcome to the Functional World", result)
    }

    public func testBind_executesRightFunction_whenEitherIsRight() {
        let either: Either<String, Int> = Either.right(10)
        var result = ""
        let left = { (string: String) in result = "\(string), Welcome to the Functional World" }
        let right = { (int: Int) in result = "Number \(int), Welcome to the Functional World" }
        either.bind(left: left, right: right)
        XCTAssertEqual("Number 10, Welcome to the Functional World", result)
    }

    public func testMap_executesLeftFunction_whenEitherIsLeft() {
        let either: Either<String, Int> = Either.left("Hello")
        let left = { (string: String) in return "\(string) World!!!" }
        let right = { (int: Int) in return int + int }

        let result = either.map(left: left, right: right)
        XCTAssertTrue(result.isLeft())
        XCTAssertFalse(either.isRight())
        XCTAssertEqual("Hello World!!!", result.leftValue())
    }

    public func testMap_executesRightFunction_whenEitherIsRight() {
        let either: Either<String, Int> = Either.right(10)
        let left = { (string: String) in return "\(string) World!!!" }
        let right = { (int: Int) in return int + int }

        let result = either.map(left: left, right: right)
        XCTAssertTrue(result.isRight())
        XCTAssertFalse(either.isLeft())
        XCTAssertEqual(20, result.rightValue())
    }
}
