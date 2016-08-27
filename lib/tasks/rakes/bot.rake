require 'tasks/bot/judge_bot.rb'

namespace :bot do

  desc "Judging bot for HackDuke events"
  task application: :environment do
    JudgeBot.run
  end

end
