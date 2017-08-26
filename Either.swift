enum Either<T1, T2> {
    case left(T1)
    case right(T2)

    public func leftValue() -> T1? {
        switch self {
        case .left(let t): return t
        case .right: return nil
        }
    }

    public func rightValue() -> T2? {
        switch self {
        case .right(let t): return t
        case .left: return nil
        }
    }

    public func isLeft() -> Bool {
        switch self {
        case .left: return true
        case _: return false
        }
    }

    public func isRight() -> Bool {
        switch self {
        case .right: return true
        case _: return false
        }
    }

    public func either<T3>(left: (T1) -> T3, right: (T2) -> T3) -> T3 {
        switch self {
        case .left(let t): return left(t)
        case .right(let t): return right(t)
        }
    }

    public func bind(left: (T1) -> Void, right: (T2) -> Void) {
        switch self {
        case .left(let t): left(t)
        case .right(let t): right(t)
        }
    }

    public func map(left: (T1) -> T1, right: (T2) -> T2) -> Either<T1, T2> {
        switch self {
        case .left: return mapLeft(f: left)
        case .right: return mapRight(f: right)
        }
    }

    private func mapLeft(f: (T1) -> T1) -> Either<T1, T2> {
        switch self {
        case .left(let t): return Either<T1, T2>.left(f(t))
        case .right(let t): return Either<T1, T2>.right(t)
        }
    }

    private func mapRight(f: (T2) -> T2) -> Either<T1, T2> {
        switch self {
        case .left(let t): return Either<T1, T2>.left(t)
        case .right(let t): return Either<T1, T2>.right(f(t))
        }
    }
}
