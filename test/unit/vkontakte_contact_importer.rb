# encoding: utf-8

dir = File.dirname(__FILE__)
require "#{dir}/../test_helper"
require 'contacts'

class VkontakteContactImporterTest < ContactImporterTestCase
  def setup
    super
    @account = TestAccounts[:vkontakte]
  end

  def test_successful_login
    Contacts.new(:vkontakte, @account.username, @account.password).contacts
  end

  def test_importer_fails_with_invalid_password
    assert_raise(Contacts::AuthenticationError) do
      Contacts.new(:vkontakte, @account.username, "wrong_password").contacts
    end
  end

  def test_importer_fails_with_blank_password
    assert_raise(Contacts::AuthenticationError) do
      Contacts.new(:vkontakte, @account.username, "").contacts
    end
  end

  def test_importer_fails_with_blank_username
    assert_raise(Contacts::AuthenticationError) do
      Contacts.new(:vkontakte, "", @account.password).contacts
    end
  end

  def test_fetch_contacts
    contacts = Contacts.new(:vkontakte, @account.username, @account.password).contacts
    @account.contacts.each do |contact|
      assert contacts.include?(contact), "Could not find: #{contact.inspect} in #{contacts.inspect}"
    end
  end
end