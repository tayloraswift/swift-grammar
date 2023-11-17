@available(*, deprecated, message: "Use 'TestMain' instead")
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public
protocol AsyncTests
{
    static
    func run(tests:Tests) async
}
@available(*, deprecated)
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension AsyncTests
{
    public static
    func main() async throws
    {
        let tests:Tests = try .init()
        await Self.run(tests: tests)
        try tests.summarize()
    }
}
