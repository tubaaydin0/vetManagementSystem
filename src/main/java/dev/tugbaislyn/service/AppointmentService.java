package dev.tugbaislyn.service;
import dev.tugbaislyn.core.exception.AppointmentException;
import dev.tugbaislyn.core.exception.ConflictException;
import dev.tugbaislyn.core.exception.NotFoundException;
import dev.tugbaislyn.core.utilies.Msg;
import dev.tugbaislyn.dao.AppointmentRepo;
import dev.tugbaislyn.dto.request.AppointmentRequest;
import dev.tugbaislyn.dto.response.AnimalResponse;
import dev.tugbaislyn.dto.response.AppointmentResponse;
import dev.tugbaislyn.dto.response.DoctorResponse;
import dev.tugbaislyn.entity.Appointment;
import dev.tugbaislyn.entity.AvailableDate;
import dev.tugbaislyn.core.config.modelMapper.ModelMapperService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AppointmentService {
    private  final AppointmentRepo appointmentRepo;
    private final ModelMapperService modelMapper;
    private  final  DoctorService doctorService;
    private final  AnimalService animalService;
    private  final AvailableDateService availableDateService;


    //Create Appointment
/*
•	Hayvanların her türlü muayenesi için doktorlardan uygun tarihlerde ve saatlerde randevu oluşturulmalıdır.
Her doktor için sadece saat başı randevu oluşturulabilir. Bir muayenenin sabit olarak bir saat süreceğini kabul edin.

•	Randevu kaydı oluştururken doktorun girilen tarihte müsait günü olup olmadığı eğer ki müsait günü varsa
randevu kayıtlarında girilen saatte başka bir randevusu olup olmadığı kontrol edilmelidir.
Her iki durum şartı sağlanırsa randevu oluşturulmalıdır.
Şart sağlanmaz ise “throw new RuntimeException("Doktor bu tarihte çalışmamaktadır!/Girilen saatte başka bir randevu mevcuttur.");”
gibi hata mesajı fırlatılmalıdır.

 */

    //Değerlendirme Formu 14,22
    public AppointmentResponse createAppointment(AppointmentRequest appointmentRequest){
        //Randevu oluşturuken girilen doktor ve hayvan idsi sistemde var mı kontrol edilir.
        try {
            DoctorResponse doctorIdDB = doctorService.getById(appointmentRequest.getDoctor().getId());
            AnimalResponse animalIdDB = animalService.getById(appointmentRequest.getAnimal().getId());
        }catch(Exception e){
            throw new NotFoundException("Doktor için: "+appointmentRequest.getDoctor().getId()+" / Hayvan için: "+appointmentRequest.getAnimal().getId()+ Msg.NOT_FOUND);
        }

        //Doktorun müsait olduğu günler bir listede tutulur.
        List<AvailableDate> doctorsAvailableDateList=availableDateService.getAvailableDatesByDoctorId(appointmentRequest.getDoctor().getId());

        //Doktorun müsait olduğu günler kontrol edilir.
        for(AvailableDate availableDate: doctorsAvailableDateList) {
        //Eğer istenen randevu günü doktorun müsait olduğu günlerden birine eşitse doktorun o günki randevu saatleri kontrol edilecek.
            if (availableDate.getAvailableDate().equals(appointmentRequest.getAppointmentDate().toLocalDate())) {
            //Doktorun bu tarih ve saatte randevusu var mı kontrol edilir
                Optional<Appointment> isThereAppointment = appointmentRepo.findByAppointmentDateAndDoctorId(appointmentRequest.getAppointmentDate(), appointmentRequest.getDoctor().getId());
                if (isThereAppointment.isEmpty()) { // Randevu yoksa yeni randevu oluşturulur.
                    Appointment appointment = modelMapper.forRequest().map(appointmentRequest, Appointment.class);
                    return modelMapper.forResponse().map(appointmentRepo.save(appointment), AppointmentResponse.class);
                }
            }
        }

        throw new AppointmentException(Msg.CONFLICT_OR_UNPROCESSABLE);//"Doktor bu tarihte çalışmamaktadır! / Girilen saatte başka bir randevu mevcuttur."

    }

    //Read
    public  AppointmentResponse getById(Long id){
        Optional<Appointment> appointmentIdDB=appointmentRepo.findById(id);
        if (appointmentIdDB.isEmpty()){
            throw new NotFoundException(id+Msg.NOT_FOUND);
        }else{
            return modelMapper.forResponse().map(appointmentIdDB.get(),AppointmentResponse.class);
        }

    }

    //Randevular kullanıcı tarafından girilen tarih aralığına ve doktora göre filtrelenmesi
    //Değerlendirme Formu 24
    public List<AppointmentResponse> getForDateAndDoctor(Long doctorId, LocalDate startDate, LocalDate endDate){
        //Dışardan gelen parametreler localdate, appointmen localdatetime türünde veri tuttuğu için atStartOfDay() ve atTime() metotları kullanarak çevirme işlemi yaptık.
        List<Appointment> listAppointment=appointmentRepo.findByDoctorIdAndAppointmentDateBetween(doctorId,startDate.atStartOfDay(),endDate.atTime(23,59,59));
        if (listAppointment.isEmpty()){
            throw new NotFoundException(Msg.NOT_FOUND_APPOINTMENT);
        }else{
            List<AppointmentResponse> appointmentResponseList=listAppointment
                    .stream()
                    .map(
                            appointment -> modelMapper.forResponse().map(appointment,AppointmentResponse.class)
                    ).collect(Collectors.toList());
            return appointmentResponseList;
        }
    }

    //Değerlendirme Formu 23
    public List<AppointmentResponse> getForDateAndAnimal(Long animalId, LocalDate startDate, LocalDate endDate){
        //Dışardan gelen parametreler localdate, appointmen localdatetime türünde veri tuttuğu için atStartOfDay() ve atTime() metotları kullanarak çevirme işlemi yaptık.
        List<Appointment> listAppointment=appointmentRepo.findByAnimalIdAndAppointmentDateBetween(animalId,startDate.atStartOfDay(),endDate.atTime(23,59,59));
        if (listAppointment.isEmpty()){
            throw new NotFoundException(Msg.NOT_FOUND_APPOINTMENT);
        }else{
            List<AppointmentResponse> appointmentResponseList=listAppointment
                    .stream()
                    .map(
                            appointment -> modelMapper.forResponse().map(appointment,AppointmentResponse.class)
                    ).collect(Collectors.toList());
            return appointmentResponseList;
        }
    }



    public List<AppointmentResponse> getAll(){
        List<AppointmentResponse> appointmentResponseList=appointmentRepo.findAll()
                .stream()
                .map(
                        appointment -> modelMapper.forResponse().map(appointment,AppointmentResponse.class)
                ).collect(Collectors.toList());

        return appointmentResponseList;
    }

    //Update
    public AppointmentResponse update(Long id, AppointmentRequest appointmentRequest){
        Optional<Appointment> appointmentIdDB=appointmentRepo.findById(id);//Sistemde randevu idsi olup olmadığına bakılır.
        Optional<Appointment> isExistAppointment=appointmentRepo.findByAppointmentDateAndDoctorIdAndAnimalId(appointmentRequest.getAppointmentDate(),appointmentRequest.getDoctor().getId(),appointmentRequest.getAnimal().getId());

        if (appointmentIdDB.isEmpty()){
            throw new NotFoundException(id+Msg.NOT_FOUND);
        }

        try {
            DoctorResponse doctorIdDB = doctorService.getById(appointmentRequest.getDoctor().getId());
            AnimalResponse animalIdDB = animalService.getById(appointmentRequest.getAnimal().getId());
        }catch(Exception e){
            throw new NotFoundException("Doktor için: "+appointmentRequest.getDoctor().getId()+" / Hayvan için: "+appointmentRequest.getAnimal().getId()+ Msg.NOT_FOUND);
        }

        if(isExistAppointment.isEmpty()) {

            //Doktor değiştirilmek istenirse;
            List<AvailableDate> doctorsAvailableDateList = availableDateService.getAvailableDatesByDoctorId(appointmentRequest.getDoctor().getId());

            //Doktorun müsait olduğu günler kontrol edilir.
            for (AvailableDate availableDate : doctorsAvailableDateList) {
                if (availableDate.getAvailableDate().equals(appointmentRequest.getAppointmentDate().toLocalDate())) {
                    //Doktorun bu tarih ve saatte randevusu var mı kontrol edilir
                    Optional<Appointment> isThereAppointment = appointmentRepo.findByAppointmentDateAndDoctorId(appointmentRequest.getAppointmentDate(), appointmentRequest.getDoctor().getId());
                    if (isThereAppointment.isEmpty()) { // Eğer sistemde doktorun aynı tarih ve saatte randevusu yoksa  güncelleme işlemi yapılır.
                        Appointment updatedAppointment = appointmentIdDB.get(); //güncelleme yapılmadan önceki randevu bilgilerini tutar.
                        updatedAppointment.setAppointmentDate(appointmentRequest.getAppointmentDate());
                        updatedAppointment.setDoctor(appointmentRequest.getDoctor());
                        updatedAppointment.setAnimal(appointmentRequest.getAnimal());
                        return modelMapper.forResponse().map(appointmentRepo.save(updatedAppointment), AppointmentResponse.class);
                    }
                }
            }
        }
        throw new AppointmentException(Msg.CONFLICT_OR_UNPROCESSABLE); //"Doktor bu tarihte çalışmamaktadır! / Girilen saatte başka bir randevu mevcuttur."
    }

    //Delete
    public  void delete(Long id){
        Optional<Appointment> appointmentIdDB=appointmentRepo.findById(id);
        if (appointmentIdDB.isEmpty()){
            throw new NotFoundException(id+Msg.NOT_FOUND);
        }else{
            appointmentRepo.delete(appointmentIdDB.get());
        }
    }
}
