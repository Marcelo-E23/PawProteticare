import { BrowserRouter, Route, Routes } from "react-router-dom";
import Login from "./pages/Login";
import Home from "./pages/Home";
import Animachado from "./pages/Animal/AnimalAchado";
import AlterarAnimachado from "./pages/Animal/AlterarAnimachado";
import CadastroAnimachado from "./pages/Animal/CadastroAnimachado";
import VisualizarAnimachado from "./pages/Animal/VisualizarAnimachado";
import Animadotado from "./pages/Animal/AnimalAdotado";
import VisualizarAnimadotado from "./pages/Animal/VisualizarAnimalAdotado";
import AlterarAnimadotado from "./pages/Animal/AlterarAnimalAdotado";
import Protese from "./pages/Protese/Protese";
import AlterarProtese from "./pages/Protese/Alterar Protese";
import CadastroProtese from "./pages/Protese/Cadastro Protese";
import VisualizarProtese from "./pages/Protese/VisualizarProtese";
import Doador from "./pages/Doador/Doador";
import VisualizarDoacao from "./pages/Doador/Visualizar Doacao";
import Adocao from "./pages/Adocao/Adocao";
import TelaAdocao from "./pages/Adocao/TelaAdoção";
import VisualizarAdocao from "./pages/Adocao/Visualizar Adocao";
import AdocoesRejeitadas from "./pages/Adocao/Adocao rejeitadas";
import AdocoesAprovadas from "./pages/Adocao/Adocao Aprovada";



export default function AppRoutes(){
    return(
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<Login/>}/>
                <Route path="/Home" element={<Home/>}/>
                <Route path="/AnimalAchado" element={<Animachado/>}/>
                <Route path="/AlterarAnimalAchado/:id" element={<AlterarAnimachado/>}/>
                <Route path="/CadastroAnimalAchado" element={<CadastroAnimachado/>}/>
                <Route path="/VisualizarAnimalAchado/:id" element={<VisualizarAnimachado/>}/>
                <Route path="/AnimalAdotado" element={<Animadotado/>}/>
                <Route path="/AlterarAnimalAdotado/:id" element={<AlterarAnimadotado/>}/>
                <Route path="/VisualizarAnimalAdotado/:id" element={<VisualizarAnimadotado/>}/>
                <Route path="/Doador" element={<Doador/>}/>
                <Route path="/VisualizarDoacao/:id" element={<VisualizarDoacao/>}/>
                <Route path="/Protese" element={<Protese/>}/>
                <Route path="/AlterarProtese/:id" element={<AlterarProtese/>}/>
                <Route path="/CadastroProtese" element={<CadastroProtese/>}/>
                <Route path="/VisualizarProtese/:id" element={<VisualizarProtese/>}/>
                <Route path="/Adocao" element={<Adocao/>}/>
                <Route path="/TelaAdocao/:id" element={<TelaAdocao/>}/>
                <Route path="/VisualizarAdocao/:id" element={<VisualizarAdocao/>}/>
                <Route path="/AdocaoRejeitadas" element={<AdocoesRejeitadas/>}/>   
                <Route path="/AdocaoAprovadas" element={<AdocoesAprovadas/>}/> 

            </Routes>
        </BrowserRouter>
    )
}