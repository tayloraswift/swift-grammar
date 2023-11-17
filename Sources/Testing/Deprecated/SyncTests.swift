@available(*, deprecated, message: "Use 'TestMain' instead")
public
protocol SyncTests
{
    static
    func run(tests:Tests)
}
@available(*, deprecated)
extension SyncTests
{
    public static
    func main() throws
    {
        let tests:Tests = try .init()
        Self.run(tests: tests)
        try tests.summarize()
    }
}
