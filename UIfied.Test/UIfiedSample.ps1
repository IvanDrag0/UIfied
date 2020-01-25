﻿
Import-Module "$PSScriptRoot\..\UIfied"

$wsb = {
    UIWindow -Caption "My Title" -Loaded {
            param ($this)
            $this.Form.Caption = $this.Form.Caption + " Loaded => " + (Get-Date).ToString()
        } -Components {
        UIStackPannel -Orientation Vertical -Components {
            UITimer  -Name Timer -Elapsed {
                param ($this)
                $this.Form.TimerLabel.Caption = Get-Date
            }
            UILabel    -Caption "Label Sample"
            UITabControl -Components {
                UITabItem -Caption "Buttons" -Components {
                    UILabel    -Caption "Button" -Name ButtonLabel
                    UIButton   -Caption "Change"  -Action {
                        param($this)
                        $this.Form.ButtonLabel.Caption = Get-Date
                    }
                }
                UITabItem -Caption "TextBoxes" -Components {
                    UILabel    -Caption "TextBox Sample" -Name TextBoxLabel
                    UITextBox  -Change {
                        param($this)
                        $this.Form.TextBoxLabel.Caption = $this.Control.Text
                    }
                }
                UITabItem -Caption "Lists" -Components {
                    UIList -Name Grid -Columns {
                        UIListColumn -Title "Column 1"
                        UIListColumn -Title "Column 2"
                    } -Items {
                        UIListItem -Components {
                            UILabel -Caption "Cell 1,1"
                            UICheckBox -Caption "Cell 1,2"
                        }
                        UIListItem -Components {
                            UILabel -Caption "Cell 2,1"
                            UICheckBox -Caption "Cell 2,2"
                        }
                        UIListItem -Components {
                            UILabel -Caption "Cell 3,1"
                            UICheckBox -Caption "Cell 3,2"
                        }
                    }
                }
                UITabItem -Caption "Radios" -Components {
                    UIRadioGroup -Components {
                        UIRadioButton -Caption "Fish"
                        UIRadioButton -Caption "Meat"
                    }
                }
                UITabItem -Caption "CheckBoxes" -Components {
                    UICheckBox -Caption "Ketchup"
                    UICheckBox -Caption "Mayo"
                }
                UITabItem -Caption "Modal" -Components {
                    UIButton   -Caption "Show"  -Action {
                        param($this)
                        $this.Form.MyModal.Show()
                    }
                    UIModal -Name MyModal -Components {
                        UIStackPannel -Orientation Vertical -Components {
                            UICheckBox -Caption "Ketchup"
                            UICheckBox -Caption "Mayo"
                            UIButton   -Caption "Hide" -Action {
                                param($this)
                                $this.Form.MyModal.Hide()
                            }
                        }
                    }
                }
                UITabItem -Caption "Timer" -Components {
                    UILabel    -Caption "TimerLabel" -Name "TimerLabel"
                    UIButton   -Caption "Run" -Name TimerStart  -Action {
                        param($this)
                        $this.Form.Timer.Start()
                        $this.Control.Enable = $false
                        $this.Form.TimerStop.Enable = $true
                    }
                    UIButton   -Caption "Stop" -Name TimerStop -Action {
                        param($this)
                        $this.Form.Timer.Stop()
                        $this.Control.Enable = $false
                        $this.Form.TimerStart.Enable = $true
                    }
                }
                UITabItem -Caption "Pickers" -Components {
                    UILabel    -Caption "DatePicker"
                    UIDatePicker -Value ([DateTime]::Today.AddDays(5)) -Name DatePicker
                    UILabel    -Caption "TimePicker"
                    UITimePicker -Value "15:27" -Name TimePicker
                    UIButton   -Caption "Time" -Action {
                        param($this)
                        $this.Control.Caption = $this.Form.TimePicker.Value
                    }
                }
            }
        }
    }
}

Set-UIWpf
$h = Get-UIHost
#cls
$h.ShowFrame($wsb)

