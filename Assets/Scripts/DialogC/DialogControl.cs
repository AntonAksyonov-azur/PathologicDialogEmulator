using System.IO;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace DialogC
{
    public class DialogControl : MonoBehaviour
    {
        [Header("Load")]
        [SerializeField] private InputField _inputFieldPath;
        [SerializeField] private UIButton _buttonLoad;

        [Header("Dialog")]
        [SerializeField] private TextMeshProUGUI _personName;
        [SerializeField] private TextMeshProUGUI _replicaCaption;
        // [SerializeField] private Text _replicaCaption;
        [SerializeField] private RectTransform _variantsTarget;
        [SerializeField] private UIButton _variantsPrefab;


        [Header("Cursor")] 
        [SerializeField] private Texture2D _cursor;

        private Dialog _currentDialog;
        private int _index;

        #region Game Cycle

        private void Awake()
        {
            Cursor.SetCursor(_cursor, Vector2.zero, CursorMode.Auto);
            
            _buttonLoad.OnClick += ButtonLoadDialogClicked;

            /*
        var dialog = new Dialog
        {
            DialogEntries = new List<DialogReplica>
            {
                new DialogReplica {Caption = "SomeCaption", Replicas = new List<string> {"Replica1", "Replica2", "Replica3"}},
                new DialogReplica {Caption = "SomeCaption2", Replicas = new List<string> {"Replica4", "Replica5", "Replica6"}},
                new DialogReplica {Caption = "SomeCaption3", Replicas = new List<string> {"Replica7", "Replica8", "Replica9"}}
            }
        };

        var path = Path.Combine(Application.dataPath, "Dialogs", "dialog1.json");
        var directory = Path.GetDirectoryName(path);
        if (!Directory.Exists(directory))
        {
            Directory.CreateDirectory(directory);
        }
        
        var json = JsonUtility.ToJson(dialog, true);
        File.WriteAllText(Path.Combine(Application.dataPath, "Dialogs", "dialog1.json"), json);
        */
        }

        #endregion

        #region Button Event Handlers

        private void ButtonLoadDialogClicked()
        {
            LoadNewDialog(_inputFieldPath.text);
        }

        #endregion

        private void LoadNewDialog(string text)
        {
            var fileContents = File.ReadAllText(text);
            _currentDialog = JsonUtility.FromJson<Dialog>(fileContents);
            _index = 0;

            ShowCurrentDialogPart();
        }

        private void ShowCurrentDialogPart()
        {
            ClearDialogPart();

            if (_index >= _currentDialog.DialogEntries.Count)
            {
                return;
            }

            // Get current
            var replica = _currentDialog.DialogEntries[ _index ];

            _personName.text = replica.PersonName;
            _replicaCaption.text = replica.Caption;

            foreach (var str in replica.Replicas)
            {
                var instance = Instantiate(_variantsPrefab, _variantsTarget);
                instance.GetComponent<TextMeshProUGUI>().text = str;
                instance.OnClick += ShowNextDialogPart;
            }
        }

        private void ShowNextDialogPart()
        {
            _index += 1;
            ShowCurrentDialogPart();
        }

        private void ClearDialogPart()
        {
            _replicaCaption.text = string.Empty;
            _personName.text = string.Empty;

            foreach (Transform tr in _variantsTarget)
            {
                Destroy(tr.gameObject);
            }
        }
    }
}