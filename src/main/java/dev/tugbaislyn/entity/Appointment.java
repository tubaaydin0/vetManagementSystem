//Değerlendirme Formu 8
package dev.tugbaislyn.entity;
import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import jakarta.validation.constraints.FutureOrPresent;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "appointment")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Appointment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "appointment_date")
    @FutureOrPresent
    @JsonFormat(pattern="yyyy-MM-dd HH:mm")
    private LocalDateTime appointmentDate;

    //Değerlendirme Formu 9
    @ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name = "doctor_id")
    private Doctor doctor;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="animal_id")
    private Animal animal;
}
