::loadScene <- function(scenePath) {
    hazelWidgetList.clear();
    hazelWidgetPositionList.clear();
    hazelSelectedWidget = -1;
    hazelRootWidget = null;
    
    if (fileExists(scenePath)) {
        local sceneConf = jsonRead(fileRead(scenePath));
        
        foreach (widget in sceneConf.widgets) {
            local instanceArgs = ""
            for (local i = 0; i<widget.args.len(); i++) {
                switch (widget.argtypes[i]) {
                    case "int":
                    case "bool":
                        instanceArgs += widget.args[i]
                        break
                    case "string":
                        instanceArgs += format("\"%s\"", widget.args[i]);
                        break
                }
                
                if (i != widget.args.len()-1) instanceArgs += ","
            }
            
            for (local i = 0; i<widget.children.len(); i++) {
                widget.children[i] = widget.children[i].tointeger();
            }
            
            dostr(format("hazelWidgetList.append(%s(%s));", widget.widgettype, instanceArgs))
        }
        hazelRootWidget = hazelWidgetList[sceneConf.root.tointeger()]
    }
}