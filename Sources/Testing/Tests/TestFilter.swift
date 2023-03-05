public
enum TestFilter
{
    @available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
    case regex([Regex<Substring>])
    case path([String])
}
extension TestFilter
{
    init(arguments:ArraySlice<String>) throws
    {
        if #available(macOS 13, iOS 16, tvOS 16, watchOS 9, *)
        {
            self = .regex(try arguments.map { try .init($0, as: Substring.self) })
        }
        else
        {
            self = .path(.init(arguments))
        }
    }
}
extension TestFilter
{
    public static
    func ~= (self:Self, path:[String]) -> Bool
    {
        switch self
        {
        case .path(let filter):
            for (filter, component):(String, String) in zip(filter, path)
                where filter != component
            {
                return false
            }
        
        case .regex(let filter):
            for (filter, component):(Regex<Substring>, String) in zip(filter, path)
            {
                if  case nil = try? filter.wholeMatch(in: component)
                {
                    return false
                }
            }
        }
        return true
    }
}
