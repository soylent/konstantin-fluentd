Puppet::Type.type(:package).provide(:tdagent, parent: :gem, source: :gem) do
  desc ''
  commands gemcmd: '/opt/td-agent/usr/sbin/td-agent-gem'
end
