import Header from '../../../components/Header';
import table from '../../../css/table.module.css';
import styles from './doador.module.css';
import endFetch from '../../../axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import { useEffect, useState } from 'react';
import style from './doador.module.css';
import botao from '../../../css/botao.module.css'
import { useNavigate } from 'react-router-dom';


export default function Doador() {
    const [doacao, setDoacao] = useState([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();


    const getDoacao = async () => {
        try {
            const response = await endFetch.get("/doacao"); 
            setDoacao(response.data);
            console.log(doacao);
        } catch (error) {
            console.error(<p className={style}>Erro ao carregar os dados</p>, error);
        } finally {
            setLoading(false); 
        }
    };

    const navCadastro = () => {
        navigate('/CadastroDoador');
    }
    
    useEffect(() => {
        getDoacao();
    }, []);

    if (loading) {
        return <div className={style.carregando}>Carregando...</div>;
    }

    return (
        <>
            <Header />
            <div className={table.tabela}>
                {doacao.length === 0 ? (
                    <div className={style.semcadastro}>
                        <p>Sem doações cadastradas.</p>
                    </div>
                ) : (
                    <div className={styles.tabela}>
                        <table className="table table-success table-striped-columns">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>ID do Doador</th>
                                    <th>Tipo</th>
                                    <th>Valor</th>
                                    <th>Data</th>
                                </tr>
                            </thead>
                            <tbody>
                                {doacao.map((doacao) => (
                                    <tr key={doacao.id}>
                                        <td>{doacao.id}</td>
                                        <td>{doacao.doador_id}</td>
                                        <td>{doacao.tipodoacao}</td>
                                        <td>{doacao.valor}</td>
                                        <td>{doacao.data}</td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                        
                    </div>
                    
                )}
                <button type="button" className={botao.bgreen} onClick={navCadastro}>
                    Inserir
                </button>
            </div>
        </>
    );
}
