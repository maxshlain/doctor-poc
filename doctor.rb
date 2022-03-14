# frozen_string_literal: true
title 'zFluentd Tests'

control 'zfluentd-01' do
  title 'Docker config'
  desc 'Docker configration is correct'

  describe json('/etc/docker/daemon.json') do
    its('log-driver') { should eq 'fluentd' }
    its(%w[log-opts fluentd-address]) { should eq '0.0.0.0:24224' }
    its(%w[log-opts tag]) { should eq 'containers/{{.Name}}/{{.ID}}' }
  end

  describe docker_container('zfluentd') do
    it { should exist }
    it { should be_running }
    its('repo') { should eq 'fluentd_zfluentd' }
    its('ports') { should eq '5140/tcp, 0.0.0.0:24224->24224/tcp, :::24224->24224/tcp' }
    its('command') { should eq 'tini -- /bin/entrypoint.sh fluentd' }
  end
end

control 'zfluentd-02' do
  title 'fluentd.conf'
  desc 'valide fluentd.conf correctness'

  describe file('/opt/zerto/zlinux/fluentd/config/fluent.conf') do
    its('content') { should match '^\s+@type rolling_file' }
    its('content') { should match '^\s+flush_interval 5s' }
  end
end

control 'zfluentd-03' do
  title 'Log folders'
  desc 'Log folders exist for known containers'

  describe directory('/var/log/zerto/containers/zfluentd') do
    it { should exist }
  end

  describe directory('/var/log/zerto/containers/registry') do
    it { should exist }
  end

  describe directory('/var/log/zerto/containers/traefik') do
    it { should exist }
  end

  describe directory('/var/log/zerto/containers/zkeycloak') do
    it { should exist }
  end

  describe directory('/var/log/zerto/containers/zkeycloak-db') do
    it { should exist }
  end
end

# TODO
# check how to mix config and validation
# validate rolling on max log file size
# validate rolling on total