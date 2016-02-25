wifi.setmode(wifi.STATION)
wifi.sta.config("TESTE VIRUS","winarrel")
print(wifi.sta.getip())
led1 = 3
led2 = 4
gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        file.open("index.txt", "r");
    
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        aux = file.readline();
        while (aux ~= nil) do
            buf = buf..aux;
            aux = file.readline();
        end

        file.close();
        
        local _on,_off = "",""
        if(_GET.pin == "ON1")then
            gpio.write(led1, gpio.HIGH);
        elseif(_GET.pin == "OFF1")then
            gpio.write(led1, gpio.LOW);
        elseif(_GET.pin == "ON2")then
            gpio.write(led2, gpio.HIGH);
        elseif(_GET.pin == "OFF2")then
            gpio.write(led2, gpio.LOW);
        end
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)