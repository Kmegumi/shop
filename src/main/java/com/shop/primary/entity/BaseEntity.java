package com.shop.primary.entity;

import javax.persistence.*;
import javax.persistence.Column;
import java.io.Serializable;
import java.time.LocalDateTime;

@MappedSuperclass
public class BaseEntity implements Serializable {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long id;

    @Version
    @Column(name = "version",columnDefinition = "bigint default 0", nullable = false)
    private Long version;

    /** 创建时间 */
	@Column(name="create_time", updatable=false, nullable = false)
	private LocalDateTime createTime;

	/** 最后修改时间 */
	@Column(name="last_update_time", nullable = false)
	private LocalDateTime lastUpdateTime;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getVersion() {
		return version;
	}

	public void setVersion(Long version) {
		this.version = version;
	}

	public LocalDateTime getCreateTime() {
		return createTime;
	}

	public void setCreateTime(LocalDateTime createTime) {
		this.createTime = createTime;
	}

	public LocalDateTime getLastUpdateTime() {
		return lastUpdateTime;
	}

	public void setLastUpdateTime(LocalDateTime lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}

	@Override
	public String toString() {
		return "BaseEntity{" +
				"id=" + id +
				", version=" + version +
				", createTime=" + createTime +
				", lastUpdateTime=" + lastUpdateTime +
				'}';
	}
}
