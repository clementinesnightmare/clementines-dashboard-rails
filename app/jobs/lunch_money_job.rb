# frozen_string_literal: true

# Job that runs once every day to allot lunch money
# to all users in the database.
class LunchMoneyJob
  include Sidekiq::Job

  sidekiq_options lock: :until_executed

  LUNCH_MONEY_PER_DAY = 0

  def perform(*_args)
    logger = Rails.logger
    logger.info 'Starting Lunch Money job'

    User.transaction do
      User.find_each do |u|
        process_user(u, logger)
      end
    end

    logger.info 'Finished Lunch Money job'
  end

  def process_user(user, logger)
    logger.info { "#{user.eth_address} earned #{LUNCH_MONEY_PER_DAY} lunch money" }

    user.with_lock do
      user.lunch_money += LUNCH_MONEY_PER_DAY
      user.save!
    end
  end
end
