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
import Doador from "./pages/Doador/Doador";
import Adocao from "./pages/Adocao/Adocao";


export default function AppRoutes(){
    return(
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<Home/>}/>
                <Route path="/Home" element={<Home/>}/>
                <Route path="/AnimalAchado" element={<Animachado/>}/>
                <Route path="/AlterarAnimalAchado/:id" element={<AlterarAnimachado/>}/>
                <Route path="/CadastroAnimalAchado" element={<CadastroAnimachado/>}/>
                <Route path="/VisualizarAnimalAchado/:id" element={<VisualizarAnimachado/>}/>
                <Route path="/AnimalAdotado" element={<Animadotado/>}/>
                <Route path="/AlterarAnimalAdotado/:id" element={<AlterarAnimadotado/>}/>
                <Route path="/VisualizarAnimalAdotado/:id" element={<VisualizarAnimadotado/>}/>
                <Route path="/Doador" element={<Doador/>}/>
                <Route path="/Adocao" element={<Adocao/>}/>
            </Routes>
        </BrowserRouter>
    )
}