#shellcheck shell=sh

Describe 'Image type'
  image() {
  sh entrypoint.sh '-a image' '-i knqyf263/vuln-image:1.2.3' '-b table' '-h image.test' '-g CRITICAL';
  }
  sarif() {
  sh entrypoint.sh '-a image' '-i knqyf263/vuln-image:1.2.3' '-b sarif' '-h image-sarif.test' '-g CRITICAL';
  }
  Before 'image' 'sarif'

  compare_images() {
    echo "$(diff ./spec/test-image.txt image.test)"
  }

  compare_sarif() {
    echo "$(diff ./spec/test-image.sarif image-sarif.test)"
  }

  It '- compare image results'
    When run compare_images
    The output should eq ""
  End

  It '- compare image sarif results'
    When run compare_sarif
    The output should eq ""
  End
End

Describe 'Config type'
  config() { sh entrypoint.sh '-a config' '-j .' '-b table' '-h config.test'; }
  Before 'config'

  compare_config() {
    echo "$(diff ./spec/test-config.txt config.test)"
  }

  It '- compare results'
    When run compare_config
    The output should eq ""
  End
End

Describe 'rootfs type'

  It '- compare results'
    When run ./entrypoint.sh '-a rootfs' '-j .'
    The stdout should match pattern '*Number of language-specific files: 0*'
  End
End
