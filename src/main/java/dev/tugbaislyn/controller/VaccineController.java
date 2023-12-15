package dev.tugbaislyn.controller;

import dev.tugbaislyn.dto.request.VaccineRequest;
import dev.tugbaislyn.dto.request.VaccineWillExpireRequest;
import dev.tugbaislyn.dto.response.VaccineResponse;
import dev.tugbaislyn.service.VaccineService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/v1/vaccine")
@RequiredArgsConstructor
public class VaccineController {
    private  final VaccineService vaccineService;

    //Create
     @PostMapping()
     @ResponseStatus(HttpStatus.CREATED)
     public VaccineResponse create(@Valid @RequestBody VaccineRequest vaccineRequest){
        return vaccineService.create(vaccineRequest);
    }


    //Read

    //Aşının idsine göre listeleme
    @GetMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public VaccineResponse getById(@PathVariable ("id") Long id){
        return vaccineService.getById(id);
    }


    //Hayvan idye göre aşı listesi
    @GetMapping("/animal/{id}")
    @ResponseStatus(HttpStatus.OK)
    public List<VaccineResponse> getByAnimalId(@PathVariable ("id") Long id){

        return vaccineService.getByAnimalId(id);
    }

    //Bitiş süresi yaklaşan hayvanların listesi
    @GetMapping("/animal/vaccinesWillExpire")
    @ResponseStatus(HttpStatus.OK)
    public List<VaccineResponse> getByAnimalsByWillExpire(@RequestBody VaccineWillExpireRequest vaccineWillExpireRequest){
        return vaccineService.getByAnimalsByWillExpire(vaccineWillExpireRequest);
    }


    //Tüm aşıların listesi
    @GetMapping()
    @ResponseStatus(HttpStatus.OK)
    public List<VaccineResponse> getAll(){
        return vaccineService.getAll();
    }

    //Update
    @PutMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public  VaccineResponse update(@Valid @PathVariable("id") Long id,@RequestBody VaccineRequest vaccineRequest){
        return vaccineService.update(id,vaccineRequest);
    }


    //Delete
    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public void delete(@PathVariable("id") Long id){
        vaccineService.delete(id);
    }

}
