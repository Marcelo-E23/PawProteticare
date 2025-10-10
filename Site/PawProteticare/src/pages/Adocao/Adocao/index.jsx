import style from './adocao.module.css';
import table from '../../../css/table.module.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import Header from '../../../components/Header';
import { useEffect, useState } from 'react';
import endFetch from '../../../axios';  
import { useNavigate } from 'react-router-dom';
import botao from '../../../css/botao.module.css'


export default function Adocao() {
    const [adocao, setAdocao] = useState([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    const getAdocao = async () => {
        try {
            const response = await endFetch.get("/solicitacaoadocao"); 
            setAdocao(response.data);
            console.log(adocao) 
        } catch (error) {
            console.error(<p className={style.erro}>Erro ao carregar os dados</p>, error);
        } finally {
            setLoading(false); 
        }
    };

    const navAceitar = () => {
        navigate('/solicitacaoadocao');
    };

    const navRecusar = () => {
        navigate('/solicitacaoadocao');
    };

    const navVisualizar = (id) => {
        navigate(`/VisualizarAnimachado/${id}`);
    };

    useEffect(() => {
        getAdocao();
    }, []);

    if (loading) {
        return <div className={style.carregando}>Carregando...</div>;
    }

    return (
        <>
            <Header />
            <div className={table.tabela}>
                {adocao.length === 0 ? (
                    <div className={style.semcadastro}>
                        <p >Sem solicitações de adoçâo.</p>
                    </div>
                ) : (
                    <table className="table table-success table-striped-columns">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Solicitante</th>
                                <th>Data</th>
                                <th>Animal</th>
                                <th className={style.visualizar}><p>Visualizar</p></th>
                            </tr>
                        </thead>
                        <tbody>
                            {adocao.map((adocao) => (
                                <tr key={adocao.id}>
                                    <td>{adocao.id}</td>
                                    <td>{adocao.propietario}</td>
                                    <td>{adocao.data_solitacao}</td>
                                    <td>{adocao.id.animachado}</td>
                                    <td className={table.icon} onClick={() => navVisualizar(adocao.id)}>
                                        <FcBinoculars size="3rem" />
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                )}
                <button type="button" className={botao.bgreen} onClick={navCadastro}>
                    Inserir
                </button>
            </div>
        </>
    );
}
