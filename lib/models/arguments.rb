# frozen_string_literal: true

require_relative "../concerns/output_writer"

class Arguments
  include OutputWriter

  def initialize(provider, command, issue_content)
    @args = argument_class(provider, command, issue_content)
  end

  def argument_class(provider, command, issue_content)
    provider.module.const_get(command.classify).new(issue_content, command)
  end

  def to_output
    arguments = @args.to_a
    return if arguments.blank?

    set_output(
      "args",
      arguments.map do |a|
        next a unless a.include?(" ")

        a.inspect
      end.join(" ")
    )
  end
end
