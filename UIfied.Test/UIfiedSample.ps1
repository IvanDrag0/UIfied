﻿
Import-Module "$PSScriptRoot\..\UIfied"

$wsb = {
    UIWindow -Caption "My Title" -Loaded {
            param ($this)
            $this.Form.Caption = $this.Form.Caption + " Loaded => " + (Get-Date).ToString()
        } -Components {
        UIStackPanel -Orientation Vertical -Components {
            UITimer  -Name Timer -Elapsed {
                param ($this)
                $this.Form.TimerLabel.Caption = Get-Date
            }
            UILabel    -Caption "Label Sample"
            UITabControl -Components {
                UITabItem -Caption "Buttons" -Components {
                    UILabel    -Caption "Button" -Name ButtonLabel
                    UIButton   -Caption "" -Name MyButton -Action {
                        param($this)
                        $this.Form.ButtonLabel.Caption = Get-Date
                        $this.Form.MyButton.Icon = (Get-UIIcon -Kind "add")
                    } -Icon (UIIcon -Kind "delete")
                    UIIcon -Kind "query_builder"
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
                    UIButton   -Caption "Clear"  -Action {
                        param($this)
                        $this.Form.Grid.Clear()
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
                    UIModal -Name MyModal -Title "MY TITLE" -Components {
                        UIStackPanel -Orientation Vertical -Components {
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
                UITabItem -Caption "Browsers" -Components {
                    UIBrowser -Name Browser -Columns {
                        UIListColumn -Title "Id" -Name Id
                        UIListColumn -Title "Description" -Name Description
                    } -Edit {
                        param($this)
                        $this.Form.ButtonLabel.Caption = $this.Control.CurrentRow | ConvertTo-Json
                    } -AddNew {
                        param($this)
                        $this.Control.Data += @{Id = "dd"; Description = Get-Date }
                        $this.Control.Refresh()
                    } -Data @(
                        1..203 | ForEach-Object { @{Id = $_; Description = "Desc $_  jkdf kjafsd j fdas jfas jfas djaf sj "} }
                    ) -PageRows 10
                }
                UITabItem -Caption "DropDownMenus" -Components {
                    UIDropDownMenu -Caption "my dropdown" -Components {
                        UIMenuItem   -Caption "Menu 1" -Action {
                            param($this)
                            $this.Control.Caption = Get-Date
                        }
                        UIMenuItem   -Caption "Menu 2" -Action {
                            param($this)
                            $this.Control.Caption = Get-Date
                        }
                    }
                }
                UITabItem -Caption "AutoCompletes" -Components {
                    UIAutoComplete -Text "AB" -ItemsRequested {
                        param($this)
                        Get-UIAutoCompleteItem -Id "id2" -Text ($this.Text + " adios")
                        Get-UIAutoCompleteItem -Id "id1" -Text ([DateTime]::Now.ToString())
                        Get-UIAutoCompleteItem -Id "id3" -Text ($this.Text + " afd adios")
                        Get-UIAutoCompleteItem -Id "id4" -Text ([DateTime]::Now.ToString())
                    }
                }
                UITabItem -Caption "Cards" -Components {
                    UICard -Caption MyTitle -Name MyCard -Icon (UIIcon -Kind delete) -Components {
                        UILabel  -Caption "Card body content here"
                        UIButton -Caption "Change" -Action {
                            param($this)
                            $this.Form.MyCard.Caption = "Hello Card"
                            $this.Form.MyCard.Icon = (Get-UIIcon -Kind add)
                        }
                    }
                }
            }
        }
    }
}

Set-UIMaterialWPF

$h = Get-UIHost
#cls
$h.ShowFrame($wsb)

