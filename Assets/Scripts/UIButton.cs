using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UIButton : MonoBehaviour, IPointerClickHandler, IPointerEnterHandler, IPointerExitHandler
{
    [SerializeField] private MaskableGraphic _targetGraphics;
    [SerializeField] private Color _defaultColor;
    [SerializeField] private Color _hoverColor;
        
    public event Action OnClick;
        
    public void OnPointerClick(PointerEventData eventData)
    {
        OnClick?.Invoke();
    }

    public void OnPointerEnter(PointerEventData eventData)
    {
        if (_targetGraphics != null)
        {
            _targetGraphics.color = _hoverColor;
        }
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        if (_targetGraphics != null)
        {
            _targetGraphics.color = _defaultColor;
        }
    }
}