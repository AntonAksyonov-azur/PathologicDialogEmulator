using UnityEngine;

public class InterfaceSwitcher : MonoBehaviour
{ 
    [Header("Dialog")]
    [SerializeField] private GameObject _dialogControl;
    [SerializeField] private UIButton _buttonDialog;

    [Header("ProgressBar")]
    [SerializeField] private GameObject _progressBarControl;
    [SerializeField] private UIButton _buttonProgressBar;

    #region Game Cycle

    private void Awake()
    {
        _buttonDialog.OnClick += ButtonDialogClicked;
        _buttonProgressBar.OnClick += ButtonProgressBarClicked;
    }
    
    #endregion

    #region Button Event Handlers

    private void ButtonDialogClicked()
    {
        _dialogControl.SetActive(true);
        _progressBarControl.SetActive(false);
    }

    private void ButtonProgressBarClicked()
    {
        _dialogControl.SetActive(false);
        _progressBarControl.SetActive(true);
    }

    #endregion
}