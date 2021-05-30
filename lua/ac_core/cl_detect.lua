function HelixACDetect(reason)
    net.Start('HelixAC::Detect')
        net.WriteInt(helixac.cfg['BanOrKick'],8)
        net.WriteString(reason)
    net.SendToServer()
end