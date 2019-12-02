
class WPFElement : UIElement {

    WPFElement() {
        $this.WrapProperty("Enable", "IsEnabled")
        Add-Member -InputObject $this -Name Visible -MemberType ScriptProperty -Value {
            $this.NativeUI.Visibility -eq [System.Windows.Visibility]::Visible
        } -SecondValue {
            if ($args[0]) {
                $this.NativeUI.Visibility = [System.Windows.Visibility]::Visible
            } else {
                $this.NativeUI.Visibility = [System.Windows.Visibility]::Collapsed
            }
        }
        $this.AddNativeUIChild = {
            param (
                [WPFElement] $element
            )
            $this.NativeUI.AddChild($element.NativeUI)
        }
    }
}

class WPFHost : UIHost {

    [void] ShowFrame([WindowBase]$window) {
        $window.ShowDialog()
    }

}

class WPFWindow : WindowBase {

    WPFWindow() {
        $this.SetNativeUI([system.windows.window]::new())
        $this.WrapProperty("Caption", "Title")
        $this.AddNativeUIChild = {
            param (
                [WPFElement] $element
            )
            $this.NativeUI.Content = $element.NativeUI
        }
    }
    
    [void] ShowDialog() {
        $this.NativeUI.ShowDialog()
    }

}

class WPFStackPanel : WPFElement {

    WPFStackPanel() {
        $this.SetNativeUI([System.Windows.Controls.StackPanel]::new())
        $this.WrapProperty("Orientation", "Orientation")
    }
}

class WPFLabel : WPFElement {

    WPFLabel() {
        $this.SetNativeUI([System.Windows.Controls.Label]::new())
        $this.WrapProperty("Caption", "Content")
    }
}

class WPFButton : WPFElement {
    [ScriptBlock] $Action = { }

    WPFButton() {
        $this.SetNativeUI([System.Windows.Controls.Button]::new())
        $this.WrapProperty("Caption", "Content")
        $this.NativeUI.Add_Click({ $this.Control.OnAction() })
    }

    [void] OnAction() {
        Invoke-Command -ScriptBlock $this.Action -ArgumentList $this
    }
}

class WPFTextBox : WPFElement {
    [ScriptBlock] $Change = { }

    WPFTextBox() {
        $this.SetNativeUI([System.Windows.Controls.TextBox]::new())
        $this.WrapProperty("Text", "Text")
        $this.NativeUI.Add_TextChanged({ $this.Control.OnChange() })
    }

    [void] OnChange() {
        Invoke-Command -ScriptBlock $this.Change -ArgumentList $this
    }

}

class WPFCheckBox : WPFElement {
    [ScriptBlock] $Click = { }

    WPFCheckBox() {
        $this.SetNativeUI([System.Windows.Controls.CheckBox]::new())
        $this.WrapProperty("Caption", "Content")
        $this.WrapProperty("IsChecked", "IsChecked")
        $this.NativeUI.Add_Click({ $this.Control.OnClick() })
    }

    [void] OnClick() {
        Invoke-Command -ScriptBlock $this.Click -ArgumentList $this
    }

}

class WPFRadioButton : WPFElement {
    [ScriptBlock] $Click = { }

    WPFRadioButton() {
        $this.SetNativeUI([System.Windows.Controls.RadioButton]::new())
        $this.WrapProperty("Caption", "Content")
        $this.WrapProperty("IsChecked", "IsChecked")
        $this.NativeUI.Add_Click({ $this.Control.OnClick() })
    }

    [void] OnClick() {
        Invoke-Command -ScriptBlock $this.Click -ArgumentList $this
    }

}

class WPFRadioGroup : WPFElement {
    hidden $StackPanel

    WPFRadioGroup() {
        $this.SetNativeUI([System.Windows.Controls.GroupBox]::new())
        $this.StackPanel = [System.Windows.Controls.StackPanel]::new()
        $this.NativeUI.Content = $this.StackPanel
        $this.AddNativeUIChild = {
            param (
                [WPFElement] $element
            )
            $this.StackPanel.AddChild($element.NativeUI)
        }
    }

}
