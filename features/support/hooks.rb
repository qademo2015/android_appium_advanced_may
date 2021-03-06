Before do
  $driver.start_driver
end

After do |scenario|
  #scenario.name
  system("adb logcat -d >> logcat_logs.txt")

  if scenario.failed?
    unless File.directory?("screenshots")
      FileUtils.mkdir_p("screenshots")
    end

    time_stamp = Time.now.strftime("%Y-%m-%d_at_%H.%M.%S")
    screenshot_name = "#{time_stamp}.png"
    screenshot_file = File.join("screenshots", screenshot_name)
    $driver.screenshot(screenshot_file)
    embed("screenshots/#{screenshot_file}", "image/png")
  end

  $driver.driver_quit
end

AfterConfiguration do
  FileUtils.rm_r("screenshots") if File.directory?("screenshots")
end