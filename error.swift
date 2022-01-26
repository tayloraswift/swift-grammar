protocol TraceableError:Error, CustomStringConvertible 
{
    static 
    var namespace:String 
    {
        get 
    }
    var next:Error? 
    {
        get 
    }
    var context:[String]
    {
        get 
    }
}
protocol TraceableErrorRoot:TraceableError 
{
    var message:String 
    {
        get 
    }
}
extension TraceableErrorRoot 
{
    var context:[String]
    {
        [self.message]
    }
    var next:Error? 
    {
        nil 
    }
}
extension TraceableError 
{
    fileprivate 
    var components:(header:String, messages:[String])
    {
        var namespace:String        = Self.namespace
        var messages:[String]       = self.context 
        
        var current:TraceableError  = self 
        while let next:Error        = current.next 
        {
            guard let next:TraceableError = next as? TraceableError 
            else 
            {
                // generic Swift.Error 
                namespace           = String.init(reflecting: Swift.type(of: next))
                messages.append(String.init(describing: next))
                break 
            }
            
            current                 = next
            namespace               = Swift.type(of: next).namespace 
            messages.append(contentsOf: next.context)
        }
        return (namespace, messages) 
    }
    
    @StringBuilder
    var description:String 
    {
        let (header, messages):(String, [String])   = self.components 
        if let root:String                          = messages.last 
        {
            "\("\(header):", colored: .red) \(root)".bolded
            for note:String in messages.dropLast().reversed()
            {
                "\("note:".bolded) \(note)"
            }
        }
        else 
        {
            "\("\(header)", colored: .red, bolded: true)"
        }
    }
}
