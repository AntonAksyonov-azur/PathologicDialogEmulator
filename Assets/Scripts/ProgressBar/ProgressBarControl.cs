using DG.Tweening;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ProgressBar
{
    public class ProgressBarControl : MonoBehaviour
    {
        [Header("Interface")]
        [SerializeField] private Image _background;
        [SerializeField] private Image _topNormal;
        [SerializeField] private Image _topReverse;
        [SerializeField] private Button _button;
        
        [Header("Control Full")]
        [SerializeField] private float _from = 1.0f;
        [SerializeField] private float _to = 0.5f;
        [SerializeField] private float _time = 8;
        [SerializeField] private Ease _easeType = Ease.OutQuint;
        
        [SerializeField] private Color _fullPulseColor = Color.cyan;
        [SerializeField] private float _fullPulseTime = 0.5f;
        [SerializeField] private Ease _fullEaseType = Ease.OutQuint;
        [SerializeField] private int _fullPulseCount = 16;

        [Header("Control Reverse")]
        [SerializeField] private bool _showReverse;
        [SerializeField] private Color _reversePulseColor = Color.cyan;
        [SerializeField] private float _reversePulseTime = 0.5f;
        [SerializeField] private Ease _reverseEaseType = Ease.OutQuint;
        [SerializeField] private int _reversePulseCount = 16;
        
        [Header("Run")]
        [SerializeField] private bool _run;

        private Sequence _sequence1;
        private Sequence _sequence2;

        #region Game Cycle

        private void Awake()
        {
            _button.onClick.AddListener(ButtonRunTweenClicked);
        }
        
        private void Start()
        {
            _topReverse.gameObject.SetActive(false);
        }
        
        private void Update()
        {
            if (_run)
            {
                _run = false;
                ButtonRunTweenClicked();
            }
        }
        
        #endregion
        
        private void ButtonRunTweenClicked()
        {
            _sequence1?.Kill();
            _sequence2?.Kill();
            
            // 1
            _topNormal.fillAmount = _from;
            _sequence1 = DOTween.Sequence();
            _sequence1.Append(_topNormal.DOFillAmount(_to, _time).SetEase(_easeType));
            _sequence2.Insert(0, _topNormal.DOColor(_fullPulseColor, _fullPulseTime).SetEase(_fullEaseType).SetLoops(_fullPulseCount, LoopType.Yoyo));
            
            // 2
            if (_showReverse)
            {
                _topReverse.fillAmount = 1.0f - _from;
                _topReverse.gameObject.SetActive(true);

                _sequence2 = DOTween.Sequence();
                _sequence2.Append(_topReverse.DOFillAmount(1.0f - _to, _time).SetEase(_easeType));
                _sequence2.Insert(0, _topReverse.DOColor(_reversePulseColor, _reversePulseTime).SetEase(_reverseEaseType).SetLoops(_reversePulseCount, LoopType.Yoyo));
                _sequence2.Append(_topReverse.DOFade(0.0f, _reversePulseTime));
                _sequence2.AppendCallback(() => _topReverse.gameObject.SetActive(false));
            }
        }
    }
}

