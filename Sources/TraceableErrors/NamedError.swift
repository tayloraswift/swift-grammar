/// An error type that supports printing with a custom heading.
public 
protocol NamedError:CustomStringConvertible, Error 
{
    /// The heading to print instead of this error’s type identifier.
    var name:String { get }
    var message:String { get }
}
extension NamedError
{
    /// Returns a description of this error without terminal colors.
    public
    var description:String
    {
        "\(self.name): \(self.message)"
    }
}
