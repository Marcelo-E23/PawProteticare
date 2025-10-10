import Header from '../../../components/Header';
import table from '../../../css/table.module.css';
import style from './protese.module.css';
import endFetch from '../../../axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import { useEffect, useState } from 'react';
import botao from '../../../css/botao.module.css'
import { useNavigate } from 'react-router-dom';


export default function Protese() {
    const [protese, setProtese] = useState([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();


    const getProtese = async () => {
        try {
            const response = await endFetch.get("/protese"); 
            setProtese(response.data);
            console.log(protese);
        } catch (error) {
            console.error(<p className={style}>Erro ao carregar os dados</p>, error);
        } finally {
            setLoading(false); 
        }
    };

    const navCadastro = () => {
        navigate('/CadastroProtese');
    }
    
    const navVisualizar = () => {
        navigate('/VisualizarProtese');
    }
    
    useEffect(() => {
        getProtese();
    }, []);

    if (loading) {
        return <div className={style.carregando}>Carregando...</div>;
    }

    return (
        <>
            <Header />
            <div className={table.tabela}>
                {protese.length === 0 ? (
                    <div className={style.semcadastro}>
                        <p>Sem protéses cadastradas.</p>
                    </div>
                ) : (
                    <div className={styles.tabela}>
                        <table className="table table-success table-striped-columns">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nome</th>
                                    <th>Tipo</th>
                                    <th>Fabricante</th>
                                    <th>Custo</th>
                                    <th>Visualizar</th>
                                </tr>
                            </thead>
                            <tbody>
                                {protese.map((protese) => (
                                    <tr key={protese.id}>
                                        <td>{protese.id}</td>
                                        <td>{protese.nome}</td>
                                        <td>{protese.tipo}</td>
                                        <td>{protese.fabricante}</td>
                                        <td>{protese.custo}</td>
                                        <td className={table.icon} onClick={() => navVisualizar(protese.id)}>
                                            <FcBinoculars size="3rem" />
                                        </td>
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
