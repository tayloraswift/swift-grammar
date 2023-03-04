@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public
protocol AsyncTests
{
    static
    func run(tests:Tests) async
}
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
