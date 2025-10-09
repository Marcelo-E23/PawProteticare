import style from './animal.module.css';
import table from '../../css/table.module.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import Header from '../../components/Header';
import { useEffect, useState } from 'react';
import endFetch from '../../axios';  
import { useNavigate } from 'react-router-dom';
import { FcSynchronize, FcBinoculars } from 'react-icons/fc';
import botao from '../../css/botao.module.css'


export default function Animachado() {
    const [animachado, setAnimachado] = useState([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    const getAnimachado = async () => {
        try {
            const response = await endFetch.get("/animachado"); 
            setAnimachado(response.data);
            console.log(animachado) 
        } catch (error) {
            console.error(<p className={style.erro}>Erro ao carregar os dados</p>, error);
        } finally {
            setLoading(false); 
        }
    };

    const navCadastro = () => {
        navigate('/CadastroAnimachado');
    };

    const navAlterar = (id) => {
        navigate(`/AlterarAnimachado/${id}`);
    };

    const navVisualizar = (id) => {
        navigate(`/VisualizarAnimachado/${id}`);
    };

    useEffect(() => {
        getAnimachado();
    }, []);

    if (loading) {
        return <div className={style.carregando}>Carregando...</div>;
    }

    return (
        <>
            <Header />
            <div className={table.tabela}>
                {animachado.length === 0 ? (
                    <div className={style.semcadastro}>
                        <p >Sem animais cadastrados.</p>
                    </div>
                ) : (
                    <table className="table table-success table-striped-columns">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Espécie</th>
                                <th>Idade</th>
                                <th>Status</th>
                                <th>Necessidade de Protése</th>
                                <th className={style.alterar}><p>Alterar</p></th>
                                <th className={style.visualizar}><p>Visualizar</p></th>
                            </tr>
                        </thead>
                        <tbody>
                            {animachado.map((animachado) => (
                                <tr key={animachado.id}>
                                    <td>{animachado.id}</td>
                                    <td>{animachado.nome}</td>
                                    <td>{animachado.especie}</td>
                                    <td>{animachado.idade} anos</td>
                                    <td>{animachado.status}</td>
                                    <td>{animachado.protese}</td>
                                    <td className={table.icon} onClick={() => navAlterar(animachado.id)}>
                                        <FcSynchronize  size="3rem" />
                                    </td>
                                    <td className={table.icon} onClick={() => navVisualizar(animachado.id)}>
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
