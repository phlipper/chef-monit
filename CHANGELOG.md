# chef-monit

## [Unreleased](https://github.com/phlipper/chef-monit/tree/HEAD)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.5.4...HEAD)

**Closed issues:**

- Binary install no longer works as Monit 5.8.1 no longer exists  [\#63](https://github.com/phlipper/chef-monit/issues/63)

- install-monit-binary gets `STDERR: cp: cannot create regular file '/usr/bin/monit': Text file busy` [\#60](https://github.com/phlipper/chef-monit/issues/60)

- Directory name doesn't match name field in `metadata.rb` [\#49](https://github.com/phlipper/chef-monit/issues/49)

**Merged pull requests:**

- Fix binary install [\#71](https://github.com/phlipper/chef-monit/pull/71) ([phlipper](https://github.com/phlipper))

- Fix converge error caused by overwriting runnig bin file [\#70](https://github.com/phlipper/chef-monit/pull/70) ([fulloflilies](https://github.com/fulloflilies))

- Fix LWRP notifications [\#69](https://github.com/phlipper/chef-monit/pull/69) ([phlipper](https://github.com/phlipper))

- Glassdoor updates [\#68](https://github.com/phlipper/chef-monit/pull/68) ([phlipper](https://github.com/phlipper))

- Project updates and cleanup [\#67](https://github.com/phlipper/chef-monit/pull/67) ([phlipper](https://github.com/phlipper))

- Much needed updates [\#66](https://github.com/phlipper/chef-monit/pull/66) ([rickhull](https://github.com/rickhull))

- Much needed update [\#65](https://github.com/phlipper/chef-monit/pull/65) ([rickhull](https://github.com/rickhull))

- Fixing LWRP's `updated_by_last_action` setting [\#62](https://github.com/phlipper/chef-monit/pull/62) ([dougbarth](https://github.com/dougbarth))

- Fixes broken binary download url [\#61](https://github.com/phlipper/chef-monit/pull/61) ([fromonesrc](https://github.com/fromonesrc))

- Updating `install_binary.rb` to add support for rhel platform, and changin... [\#58](https://github.com/phlipper/chef-monit/pull/58) ([smford22](https://github.com/smford22))

- add `use_inline_resources` to `monit_monitrc` provider [\#57](https://github.com/phlipper/chef-monit/pull/57) ([MrMMorris](https://github.com/MrMMorris))

- Make pid file path customisable [\#56](https://github.com/phlipper/chef-monit/pull/56) ([heryandi](https://github.com/heryandi))

## [1.5.4](https://github.com/phlipper/chef-monit/tree/1.5.4) (2014-06-29)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.5.3...1.5.4)

**Merged pull requests:**

- Support Amazon Linux for ssh \(\#51\) [\#55](https://github.com/phlipper/chef-monit/pull/55) ([phlipper](https://github.com/phlipper))

- Support 'using HOSTNAME' syntax \(\#52\) [\#54](https://github.com/phlipper/chef-monit/pull/54) ([phlipper](https://github.com/phlipper))

- Binary install \(\#48\) [\#53](https://github.com/phlipper/chef-monit/pull/53) ([phlipper](https://github.com/phlipper))

- project updates [\#50](https://github.com/phlipper/chef-monit/pull/50) ([phlipper](https://github.com/phlipper))

- Support 'using HOSTNAME' syntax [\#52](https://github.com/phlipper/chef-monit/pull/52) ([ijin](https://github.com/ijin))

- Support Amazon Linux for ssh [\#51](https://github.com/phlipper/chef-monit/pull/51) ([ijin](https://github.com/ijin))

- Binary install [\#48](https://github.com/phlipper/chef-monit/pull/48) ([foxycoder](https://github.com/foxycoder))

## [1.5.3](https://github.com/phlipper/chef-monit/tree/v1.5.3) (2014-05-24)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.5.2...1.5.3)

**Closed issues:**

- Upload this cookbook to opscode community site [\#44](https://github.com/phlipper/chef-monit/issues/44)

- Optionally install monit from source [\#39](https://github.com/phlipper/chef-monit/issues/39)

- Add encrypted credentials option for mail provider [\#34](https://github.com/phlipper/chef-monit/issues/34)

- Add a variable to remove mail configurations [\#33](https://github.com/phlipper/chef-monit/issues/33)

**Merged pull requests:**

- Fix attribute comments [\#47](https://github.com/phlipper/chef-monit/pull/47) ([dwradcliffe](https://github.com/dwradcliffe))

- Fix statefile config parameter in template monitrc.erb [\#46](https://github.com/phlipper/chef-monit/pull/46) ([mbanton](https://github.com/mbanton))

- Add source installation option [\#45](https://github.com/phlipper/chef-monit/pull/45) ([phlipper](https://github.com/phlipper))

- Add settings for `idfile` and `statefile` - \#41 [\#43](https://github.com/phlipper/chef-monit/pull/43) ([phlipper](https://github.com/phlipper))

- add `rubocop` to test suite [\#42](https://github.com/phlipper/chef-monit/pull/42) ([phlipper](https://github.com/phlipper))

- Fix bug in which Monit is not started during bootstrap [\#38](https://github.com/phlipper/chef-monit/pull/38) ([evan2645](https://github.com/evan2645))

- Allow either style of monit startup flag to work [\#36](https://github.com/phlipper/chef-monit/pull/36) ([esigler](https://github.com/esigler))

- configures encrypted smtp provider [\#35](https://github.com/phlipper/chef-monit/pull/35) ([drywheat](https://github.com/drywheat))

- Add settings for idfile and statefile options to Monit config [\#41](https://github.com/phlipper/chef-monit/pull/41) ([mvdkleijn](https://github.com/mvdkleijn))

- Allow user to install different versions of monit [\#40](https://github.com/phlipper/chef-monit/pull/40) ([drywheat](https://github.com/drywheat))

## [1.5.2](https://github.com/phlipper/chef-monit/tree/1.5.2) (2014-01-17)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.5.1...1.5.2)

**Merged pull requests:**

- Cleanup [\#32](https://github.com/phlipper/chef-monit/pull/32) ([phlipper](https://github.com/phlipper))

- Add `reload_on_change` property [\#31](https://github.com/phlipper/chef-monit/pull/31) ([phlipper](https://github.com/phlipper))

- Added `reload_on_change` property that defines if monit should be reloaded when configuration changes \(default: true\) [\#30](https://github.com/phlipper/chef-monit/pull/30) ([pauloricardomg](https://github.com/pauloricardomg))

## [1.5.1](https://github.com/phlipper/chef-monit/tree/1.5.1) (2014-01-10)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.5.0...1.5.1)

**Merged pull requests:**

- added option `alert_ignore_events` to avoid certain types of event alerts [\#29](https://github.com/phlipper/chef-monit/pull/29) ([pauloricardomg](https://github.com/pauloricardomg))

- Update the recipe to use a version [\#16](https://github.com/phlipper/chef-monit/pull/16) ([mahmoudimus](https://github.com/mahmoudimus))

## [1.5.0](https://github.com/phlipper/chef-monit/tree/1.5.0) (2013-12-21)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.4.0...1.5.0)

**Merged pull requests:**

- Web address [\#28](https://github.com/phlipper/chef-monit/pull/28) ([phlipper](https://github.com/phlipper))

- Reload monit [\#27](https://github.com/phlipper/chef-monit/pull/27) ([phlipper](https://github.com/phlipper))

- whyrun support for monitrc provider [\#26](https://github.com/phlipper/chef-monit/pull/26) ([phlipper](https://github.com/phlipper))

- Fix logging [\#25](https://github.com/phlipper/chef-monit/pull/25) ([phlipper](https://github.com/phlipper))

- drop 1.8.7 and 1.9.2, add 2.0.0 for TravisCI [\#24](https://github.com/phlipper/chef-monit/pull/24) ([phlipper](https://github.com/phlipper))

- Add a Bitdeli Badge to README [\#18](https://github.com/phlipper/chef-monit/pull/18) ([bitdeli-chef](https://github.com/bitdeli-chef))

- minor tweak to skip binding to an address by not providing :address =\>  ... [\#23](https://github.com/phlipper/chef-monit/pull/23) ([schettj](https://github.com/schettj))

- don't render 'use address' if no address is provided [\#22](https://github.com/phlipper/chef-monit/pull/22) ([dwradcliffe](https://github.com/dwradcliffe))

- support for reloading monit without restart [\#21](https://github.com/phlipper/chef-monit/pull/21) ([dwradcliffe](https://github.com/dwradcliffe))

- whyrun support for monitrc provider [\#20](https://github.com/phlipper/chef-monit/pull/20) ([dwradcliffe](https://github.com/dwradcliffe))

- fix logging logic in template [\#19](https://github.com/phlipper/chef-monit/pull/19) ([dwradcliffe](https://github.com/dwradcliffe))

- Fixed using monit with syslog. [\#17](https://github.com/phlipper/chef-monit/pull/17) ([mgalkiewicz](https://github.com/mgalkiewicz))

## [1.4.0](https://github.com/phlipper/chef-monit/tree/1.4.0) (2013-09-11)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.3.3...1.4.0)

## [1.3.3](https://github.com/phlipper/chef-monit/tree/1.3.3) (2013-06-19)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.3.2...1.3.3)

**Merged pull requests:**

- Add startup delay option to monit daemon in config [\#15](https://github.com/phlipper/chef-monit/pull/15) ([claco](https://github.com/claco))

- Check template updated / Restart on default monitrc configs change [\#14](https://github.com/phlipper/chef-monit/pull/14) ([claco](https://github.com/claco))

- Restart monit service if the monit config changes [\#13](https://github.com/phlipper/chef-monit/pull/13) ([claco](https://github.com/claco))

- Fix platform family logic [\#12](https://github.com/phlipper/chef-monit/pull/12) ([claco](https://github.com/claco))

## [1.3.2](https://github.com/phlipper/chef-monit/tree/1.3.2) (2013-05-01)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.3.1...1.3.2)

**Merged pull requests:**

- Makes the email notifications much more useful. [\#11](https://github.com/phlipper/chef-monit/pull/11) ([darron](https://github.com/darron))

## [1.3.1](https://github.com/phlipper/chef-monit/tree/1.3.1) (2013-04-09)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.3.0...1.3.1)

**Merged pull requests:**

- Add `mail_alerts` attribute [\#10](https://github.com/phlipper/chef-monit/pull/10) ([fixlr](https://github.com/fixlr))

## [1.3.0](https://github.com/phlipper/chef-monit/tree/1.3.0) (2013-03-29)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.2.0...1.3.0)

**Merged pull requests:**

- support other security protocols [\#9](https://github.com/phlipper/chef-monit/pull/9) ([alexism](https://github.com/alexism))

## [1.2.0](https://github.com/phlipper/chef-monit/tree/1.2.0) (2013-03-14)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.1.1...1.2.0)

**Merged pull requests:**

- Ruby 1.8.x compatibility fix and support for templates in different cookbooks [\#8](https://github.com/phlipper/chef-monit/pull/8) ([tomdz](https://github.com/tomdz))

## [1.1.1](https://github.com/phlipper/chef-monit/tree/1.1.1) (2013-03-07)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.1.0...1.1.1)

**Merged pull requests:**

- Only load default monitrc configs from an attribute [\#7](https://github.com/phlipper/chef-monit/pull/7) ([tjwallace](https://github.com/tjwallace))

- Remove executable permission from files [\#6](https://github.com/phlipper/chef-monit/pull/6) ([tjwallace](https://github.com/tjwallace))

- Fix typo in readme [\#5](https://github.com/phlipper/chef-monit/pull/5) ([dwradcliffe](https://github.com/dwradcliffe))

## [1.1.0](https://github.com/phlipper/chef-monit/tree/1.1.0) (2013-01-06)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.0.1...1.1.0)

**Closed issues:**

- Getting invoke-rc.d: initscript monit, action "restart" failed. [\#2](https://github.com/phlipper/chef-monit/issues/2)

**Merged pull requests:**

- Fixed hash syntax for ruby 1.8 [\#4](https://github.com/phlipper/chef-monit/pull/4) ([arrowcircle](https://github.com/arrowcircle))

## [1.0.1](https://github.com/phlipper/chef-monit/tree/1.0.1) (2012-12-27)

[Full Changelog](https://github.com/phlipper/chef-monit/compare/1.0.0...1.0.1)

## [1.0.0](https://github.com/phlipper/chef-monit/tree/1.0.0) (2012-12-27)

**Merged pull requests:**

- Added name to metadata.rb [\#3](https://github.com/phlipper/chef-monit/pull/3) ([auser](https://github.com/auser))

- Support for multiple node platforms [\#1](https://github.com/phlipper/chef-monit/pull/1) ([werdan](https://github.com/werdan))
