# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'prometheus ssl exporter' do
  it 'ssl_exporter works idempotently with no errors' do
    pp = 'include prometheus::ssl_exporter'
    apply_manifest(pp, catch_failures: true)
    apply_manifest(pp, catch_changes: true)
  end

  describe service('ssl_exporter') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end

  describe port(9219) do
    it { is_expected.to be_listening.with('tcp6') }
  end
end
