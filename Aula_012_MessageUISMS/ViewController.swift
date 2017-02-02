
import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate{
    
    //MARK: Outlets
    @IBOutlet weak var telefoneTextField: UITextField!
    @IBOutlet weak var mensagemTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Propriedades da TextView
        mensagemTextView.layer.borderWidth = 0.5
        mensagemTextView.text = ""
        mensagemTextView.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
        mensagemTextView.layer.cornerRadius = 8
        
        
        
    }
    
    //MARK: Actions
    @IBAction func enviarSMS(_ sender: UIButton) {
        let alerta = UIAlertController()
        let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerta.addAction(botao)
        alerta.title = "Alerta"
        
        
        if MFMessageComposeViewController.canSendText() {
            let meuMensageiro = MFMessageComposeViewController()
            meuMensageiro.messageComposeDelegate = self
            
            if !telefoneTextField.text!.isEmpty{
                meuMensageiro.recipients = [telefoneTextField.text!]
            } else {
                alerta.message = "Informe o numero do telefone"
                present(alerta, animated: true, completion: nil)
            }
            
            //Criando o corpo da mensagem
            if !mensagemTextView.text.isEmpty {
                meuMensageiro.body = mensagemTextView.text
            } else {
                alerta.message = "Informe o conteudo da mensagem"
                present(alerta, animated: true, completion: nil)
            }
            
            meuMensageiro.show(self, sender: nil)
            //present(meuMensageiro, animated: true)
        } else {
            alerta.message = "Nao sou capaz de mandar esta mensagem"
            present(alerta, animated: true, completion: nil)
        }

    }

    //MARK: Metodos de MFMessageComposeViewControllerDelegate
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        controller.dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: Metodos de UIResponder
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }


}

