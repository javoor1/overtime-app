class Post < ActiveRecord::Base
	enum status: {submitted: 0, approved: 1, rejected: 2}
	belongs_to :user
	validates :date, :rationale, :overtime_request, presence: true
	validates :overtime_request, numericality: { greater_than: 0.0 }

	scope :posts_by, ->(user) { where(user_id: user.id) }

	after_save :confirm_audit_log, if: :submitted?
	after_save :un_confirm_audit_log, if: :rejected?


	private
	def confirm_audit_log
		audit_log = AuditLog.where(user_id: self.user_id, start_date: (self.date - 7.days..self.date)).last
		p audit_log.inspect
		audit_log.confirmed! if audit_log
		# audit_log.destroy #Qué conviene destruir o confirmar?
	end

	def un_confirm_audit_log
		audit_log = AuditLog.where(user_id: self.user_id, start_date: (self.date - 7.days..self.date)).last
		audit_log.pending! if audit_log
		# audit_log.destroy #Qué conviene destruir o confirmar?
	end

end