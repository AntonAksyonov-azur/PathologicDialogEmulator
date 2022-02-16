using UnityEngine;

public class HideObject : MonoBehaviour
{
    [SerializeField] private GameObject _object;
    
    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Q))
        {
            _object.SetActive(true);
        }
        
        if (Input.GetKeyDown(KeyCode.W))
        {
            _object.SetActive(false);
        }
    }

}
